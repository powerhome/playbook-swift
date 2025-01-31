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
    private var optionsSubject: CurrentValueSubject<[PBTypeahead.Option], Never>!
    private let searchTermSubject = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    // Dependencies (dynamic)
    private var selectedOptions: [PBTypeahead.Option] = []
    private var searchText: String = ""
    private var isFocused: Bool = false
    private var clearAction: (() -> Void)?
    
    public init() {
        self.selection = .single
        self.debounce = (0, 0)  // Default no debounce
        self.placeholder = "Select"  // Default placeholder
    }
    
    func configure(
        selection: PBTypeahead.Selection,
        options: [PBTypeahead.Option],
        debounce: (time: TimeInterval, numberOfCharacters: Int),
        placeholder: String,
        selectedOptions: [PBTypeahead.Option],
        searchText: String,
        isFocused: Bool,
        clearAction: (() -> Void)?
    ) {
        self.selection = selection
        self.debounce = debounce
        self.placeholder = placeholder
        
        self.selectedOptions = selectedOptions
        self.searchText = searchText
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
    
    func updateOptions(_ newOptions: [PBTypeahead.Option]) {
        optionsSubject.send(newOptions)
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
        
        let selectedIds = Set(selectedOptions.map { $0.id })
        
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
    
    func onListSelection(index: Int, option: PBTypeahead.Option) {
        guard option.text != noOptionsText else { return }
        
        switch selection {
        case .single:
            onSingleSelection(index: index, option: option)
        case .multiple:
            onMultipleSelection(option: option)
        }
        
        showPopover = false
        searchText = ""
        reloadList()
    }
    
    private func onSingleSelection(index: Int, option: PBTypeahead.Option) {
        selectedOptions.removeAll()
        selectedOptions = [option]
        selectedIndex = index
        hoveringIndex = index
        selectedOptions.append(option)
        reloadList()
    }
    
    private func onMultipleSelection(option: PBTypeahead.Option) {
        selectedOptions.append(option)
        hoveringIndex = nil
        selectedIndex = nil
        reloadList()
    }
    
    func removeSelected(_ index: Int) {
        guard let selectedElementIndex = selectedOptions.indices.first(where: { $0 == index }) else { return }
        selectedOptions.remove(at: selectedElementIndex)
        selectedIndex = nil
        hoveringIndex = 0
        reloadList()
    }
    
    func clear() {
        if let action = clearAction {
            action()
        }
        searchText = ""
        selectedOptions.removeAll()
        selectedIndex = nil
        hoveringIndex = nil
        showPopover = false
    }
    
    func reloadList() {
        isHovering.toggle()
    }
    
    var optionsSelected: GridInputField.Selection {
        let optionsSelected = selectedOptions.map { value in
            value.text ?? value.id
        }
        return selection.selectedOptions(options: optionsSelected, placeholder: placeholder)
    }
    
    // MARK: - View Actions
    func onViewTap() {
        showPopover.toggle()
        isFocused = true
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
} 
