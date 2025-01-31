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
    @Published var searchResults: [PBTypeahead.Option] = []
    
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
        self.searchResults = options
        
        setupSubscriptions()
        
        if isFocused {
            showPopover = true
        }
        
        reloadList()
    }
    
    private func setupSubscriptions() {
        searchTermSubject
            .debounce(for: .seconds(debounce.time), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.handleSearchTextChange(text)
            }
            .store(in: &cancellables)
            
        optionsSubject
            .sink { [weak self] newOptions in
                self?.searchResults = newOptions
                self?.reloadList()
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
    
    func handleSearchTextChange(_ text: String) {
        let results = getSearchResults(text)
        searchResults = results
        reloadList()
        if !text.isEmpty {
            showPopover = true
        }
    }
    
    private func getSearchResults(_ text: String) -> [PBTypeahead.Option] {
        let shouldShowAllOptions = text.isEmpty && debounce.numberOfCharacters == 0
        let currentOptions = optionsSubject.value
        
        let filteredOptions = shouldShowAllOptions ? currentOptions : currentOptions.filter { option in
            if let optionText = option.text {
                return optionText.localizedCaseInsensitiveContains(text)
            } else {
                return option.id.localizedCaseInsensitiveContains(text)
            }
        }
        
      let selectedIds = Set(selectedOptionsBinding?.wrappedValue.map { $0.id } ?? [])
        
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
            return filteredOptions.isEmpty
                ? [emptyStateOption]
                : filteredOptions
        }
    }
} 
