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
    
    // Constants
    private(set) var noOptionsText = "No options"
    
    // State Publishers
    var optionsSubject: CurrentValueSubject<[PBTypeahead.Option], Never>!
    private let searchTermSubject = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // Dependencies (bindings)
    private var selectedOptionsBinding: Binding<[PBTypeahead.Option]>?
    private var searchTextBinding: Binding<String>?
    private var isFocused: Bool = false
    private var clearAction: (() -> Void)?
    var scrollProxy: ((String) -> Void) = { _ in }

    public init() {
        self.selection = .single
        self.debounce = (0, 0)
        self.placeholder = "Select"
    }
    
    func configure(
        selection: PBTypeahead.Selection,
        options: [PBTypeahead.Option],
        debounce: (time: TimeInterval, numberOfCharacters: Int),
        placeholder: String,
        selectedOptionsBinding: Binding<[PBTypeahead.Option]>,
        searchTextBinding: Binding<String>,
        isFocused: Bool,
        clearAction: (() -> Void)?
    ) {
        self.selection = selection
        self.debounce = debounce
        self.placeholder = placeholder
        
        self.selectedOptionsBinding = selectedOptionsBinding
        self.searchTextBinding = searchTextBinding
        self.isFocused = isFocused
        self.clearAction = clearAction
        
        self.optionsSubject = CurrentValueSubject(options)
        self.searchResults = PBTypeaheadViewModel.optionToDisplayable(options)

        setupSubscriptions()
        
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

    private func setupSubscriptions() {
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

                let firstId = self.searchResults.first!.id
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                  self.scrollProxy(firstId)
                }

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
            text: noOptionsText,
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
    func onKeyPress(_ key: KeyCode) {
        switch key {
        case .tab:
            isFocused = true
            
        case .return:
            guard showPopover,
                  let index = hoveringIndex,
                  index < searchResults.count else {
                return
            }
            let option = searchResults[index]
            onListSelection(index: index, option: option.option)

        case .backspace:
            // Only delete when search field is empty and there are selected options
            if searchTextBinding?.wrappedValue.isEmpty == true,
               let currentOptions = selectedOptionsBinding?.wrappedValue,
               !currentOptions.isEmpty {
                removeSelected(currentOptions.count - 1)  // Remove last item
            }
            
        case .downArrow:
            if !showPopover {
                showPopover = true
                hoveringIndex = 0
                return
            }
            
            let currentIndex = hoveringIndex ?? -1
            hoveringIndex = min(currentIndex + 1, searchResults.count - 1)

            guard let index = hoveringIndex, searchResults.indices.contains(index) else { return }
            scrollProxy(searchResults[index].id)

        case .upArrow:
            if !showPopover {
                showPopover = true
                hoveringIndex = searchResults.count - 1
                return
            }
            
            let currentIndex = hoveringIndex ?? searchResults.count
            hoveringIndex = max(currentIndex - 1, 0)

            guard let index = hoveringIndex, searchResults.indices.contains(index) else { return }
            scrollProxy(searchResults[index].id)

        case .escape:
            showPopover = false
            isFocused = false
        }
    }
}
#endif 
