//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTypeahead.swift
//

import SwiftUI
import Combine

@MainActor
final class PBTypeaheadViewModel: ObservableObject {
    @Published var showPopover: Bool = false
    @Published var hoveringIndex: Int?
    @Published var isHovering: Bool = false
    @Published var selectedIndex: Int?
    @Published var searchResults: [PBTypeahead.DisplayableOption] = []

    // Configuration (static)
    private(set) var selection: PBTypeahead.Selection
    private(set) var debounce: (time: TimeInterval, numberOfCharacters: Int)
    private var placeholder: String
    private var disableFiltering: Bool
    
    // Constants
    private(set) var noOptionsText = ""

    // State Publishers
    var optionsSubject: CurrentValueSubject<[PBTypeahead.Option], Never>!
    private let searchTermSubject = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // Dependencies (bindings)
    private var selectedOptionsBinding: Binding<[PBTypeahead.Option]>?
    private var searchTextBinding: Binding<String>?
    var isFocused: Bool = false
    private var clearAction: (() -> Void)?

    public init() {
        self.selection = .single
        self.debounce = (0, 0)
        self.placeholder = "Select"
        self.disableFiltering = false
    }
    
    func configure(
        selection: PBTypeahead.Selection,
        options: [PBTypeahead.Option],
        debounce: (time: TimeInterval, numberOfCharacters: Int),
        placeholder: String,
        selectedOptionsBinding: Binding<[PBTypeahead.Option]>,
        searchTextBinding: Binding<String>,
        isFocused: Bool,
        clearAction: (() -> Void)?,
        disableFiltering: Bool
    ) {
        self.selection = selection
        self.debounce = debounce
        self.placeholder = placeholder
        self.disableFiltering = disableFiltering
        self.selectedOptionsBinding = selectedOptionsBinding
        self.searchTextBinding = searchTextBinding
        self.isFocused = isFocused
        self.clearAction = clearAction
        
        self.optionsSubject = CurrentValueSubject(options)

        let selectedIds = Set(self.selectedOptionsBinding?.wrappedValue.map(\.id) ?? [])
        let filteredOptions = options.filter { option in
            !selectedIds.contains(option.id)
        }
        self.searchResults = PBTypeaheadViewModel.optionToDisplayable(filteredOptions)

        if disableFiltering {
            observeOptions()
        } else {
            observeSearchTextAndSearchResults()
        }
        
        if isFocused {
            showPopover = true
        }
        
        reloadList()
    }

    private static func optionToDisplayable(_ options: [PBTypeahead.Option]) -> [PBTypeahead.DisplayableOption] {
        options.enumerated().map { index, option in
            .init(option: option, index: index)
        }
    }

    private func observeOptions() {
        optionsSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] options in
                guard let self = self else { return }
                let selectedIds = Set(self.selectedOptionsBinding?.wrappedValue.map(\.id) ?? [])
                let results = options.filter { option in
                    !selectedIds.contains(option.id)
                }
                self.searchResults = PBTypeaheadViewModel.optionToDisplayable(results)
              
                self.reloadList()
                if !(self.searchTextBinding?.wrappedValue.isEmpty ?? true) {
                    self.showPopover = true
                }
            }
            .store(in: &cancellables)
    }

    private func observeSearchTextAndSearchResults() {
        var searchTerm = searchTermSubject.debounce(for: .seconds(debounce.time), scheduler: DispatchQueue.global()).eraseToAnyPublisher()

        if debounce.time == 0 {
            searchTerm = searchTermSubject.eraseToAnyPublisher()
        }

        searchTerm
            .receive(on: DispatchQueue.main)
            .map { [weak self] text -> (String, [PBTypeahead.Option], Set<String>) in
                guard let self = self else { return (text, [], []) }
                let currentOptions = self.optionsSubject.value
                let selectedIds = Set(self.selectedOptionsBinding?.wrappedValue.map(\.id) ?? [])
                return (text, currentOptions, selectedIds)
            }
            .receive(on: DispatchQueue.global())
            .map { [weak self] (text, options, selectedIds) -> [PBTypeahead.Option] in
                guard let self = self else { return [] }
                return self.getSearchResults(text, options: options, selectedIds: selectedIds)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] results in
                guard let self else { return }
                self.searchResults = PBTypeaheadViewModel.optionToDisplayable(results)
                self.hoveringIndex = 0
                self.reloadList()

                if !(self.searchTextBinding?.wrappedValue.isEmpty ?? true) {
                    self.showPopover = true
                }
            }
            .store(in: &cancellables)
    }
    
    private func updateSearchText(_ newText: String) {
        searchTextBinding?.wrappedValue = newText
    }
    
    private func updateSelectedOptions(_ newOptions: [PBTypeahead.Option]) {
        selectedOptionsBinding?.wrappedValue = newOptions
    }
    
    func onListSelection(index: Int, option: PBTypeahead.Option) {
        guard option.text != noOptionsText else { return }
        
        switch selection {
        case .single:
            onSingleSelection(index: index, option: option)
        case .multiple:
            onMultipleSelection(option: option)
        }

        let selectedIds = Set(self.selectedOptionsBinding?.wrappedValue.map(\.id) ?? [])
        let filteredOptions = self.optionsSubject.value.filter {
            !selectedIds.contains($0.id)
        }
        self.searchResults = PBTypeaheadViewModel.optionToDisplayable(filteredOptions)

        showPopover = false
        updateSearchText("")
        reloadList()
    }
    
    private func onSingleSelection(index: Int, option: PBTypeahead.Option) {
        updateSelectedOptions([option])
        selectedIndex = index
        hoveringIndex = index
        reloadList()
    }
    
    private func onMultipleSelection(option: PBTypeahead.Option) {
        var currentOptions = selectedOptionsBinding?.wrappedValue ?? []
        currentOptions.append(option)
        updateSelectedOptions(currentOptions)
        hoveringIndex = nil
        selectedIndex = nil
        reloadList()
    }
    
    func removeSelected(_ index: Int) {
        guard var currentOptions = selectedOptionsBinding?.wrappedValue,
              let selectedElementIndex = currentOptions.indices.first(where: { $0 == index }) else { return }
        currentOptions.remove(at: selectedElementIndex)
        updateSelectedOptions(currentOptions)
        selectedIndex = nil
        hoveringIndex = 0

        let selectedIds = Set(self.selectedOptionsBinding?.wrappedValue.map(\.id) ?? [])
        let filteredOptions = self.optionsSubject.value.filter {
            !selectedIds.contains($0.id)
        }
        self.searchResults = PBTypeaheadViewModel.optionToDisplayable(filteredOptions)

        reloadList()
    }
    
    func clear() {
        if let action = clearAction {
            action()
        }
        updateSearchText("")
        updateSelectedOptions([])
        selectedIndex = nil
        hoveringIndex = nil
        showPopover = false
    }
    
    func reloadList() {
        isHovering.toggle()
    }
    
    var optionsSelected: GridInputField.Selection {
        let options = selectedOptionsBinding?.wrappedValue ?? []
        let optionsSelected = options.map { value in
            value.text ?? value.id
        }
        return selection.selectedOptions(options: optionsSelected, placeholder: placeholder)
    }

    func optionsChanged(_ newOptions: [PBTypeahead.Option]) {
        optionsSubject.send(newOptions)
    }

    func searchTermChanged(_ newTerm: String) {
        searchTermSubject.send(newTerm)
    }
    
    private func getSearchResults(
        _ text: String,
        options: [PBTypeahead.Option],
        selectedIds: Set<String>
    ) -> [PBTypeahead.Option] {
        let shouldShowAllOptions = text.isEmpty && debounce.numberOfCharacters == 0
        
        let filteredOptions = shouldShowAllOptions ? options : options.filter { option in
            if let optionText = option.text {
                return optionText.localizedCaseInsensitiveContains(text)
            } else {
                return option.id.localizedCaseInsensitiveContains(text)
            }
        }
        
        let filteredSelectedOptions = filteredOptions.filter { option in
            !selectedIds.contains(option.id)
        }
        
        let emptyStateOption = PBTypeahead.Option(
            id: "",
            text: "",
            customView: nil
        )
        
        switch selection {
        case .multiple:
            return filteredSelectedOptions.isEmpty
                ? [emptyStateOption]
                : filteredSelectedOptions
                
        case .single:
            return filteredSelectedOptions.isEmpty
                ? [emptyStateOption]
                : filteredSelectedOptions
        }
    }
}

#if os(macOS)
extension PBTypeaheadViewModel: TypeaheadKeyboardDelegate {
    func onKeyPress(_ key: KeyCode) -> Bool {
        switch key {
        case .tab:
            isFocused = true
            return false
            
        case .return:
            guard isFocused else { return false }
            guard showPopover,
                  let index = hoveringIndex,
                  index < searchResults.count else {
                return false
            }
            let option = searchResults[index]
            onListSelection(index: index, option: option.option)
            return true

        case .backspace:
            guard isFocused else { return false }
            // Only delete when search field is empty and there are selected options
            if searchTextBinding?.wrappedValue.isEmpty == true,
               let currentOptions = selectedOptionsBinding?.wrappedValue,
               !currentOptions.isEmpty {
                removeSelected(currentOptions.count - 1)  // Remove last item
                return true
            }
            return false
            
        case .downArrow:
            guard isFocused, showPopover else { return false }
            let currentIndex = hoveringIndex ?? 0
            let newHoveringIndex = min(currentIndex + 1, searchResults.count - 1)
            hoveringIndex = newHoveringIndex
            return true

        case .upArrow:
            guard isFocused, showPopover else { return false }
            let currentIndex = hoveringIndex ?? 0
            let newHoveringIndex = max(currentIndex - 1, 0)
            hoveringIndex = newHoveringIndex
            return true

        case .space:
          return false

        case .escape:
            guard isFocused, showPopover else { return false }
            showPopover = false
            isFocused = false
            return true
        }
    }
}
#endif 
