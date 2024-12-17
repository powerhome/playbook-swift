//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTypeaheadTemplate.swift
//

import SwiftUI

public struct PBTypeaheadTemplate: View {
    private let id: Int
    private let title: String
    private let placeholder: String
    private var options: [PBTypeahead.OptionType]
    private let selection: PBTypeahead.Selection
    private let noOptionsText: String
    private let debounce: (time: TimeInterval, numberOfCharacters: Int)
    private let dropdownMaxHeight: CGFloat?
    private let listOffset: (x: CGFloat, y: CGFloat)
    private let clearAction: (() -> Void)?

    @State private var showPopover: Bool = false
    @State private var hoveringIndex: Int?
    @State private var isHovering: Bool = false
    @State private var selectedIndex: Int?
    @State private var focused: Bool = false
    @Binding var selectedOptions: [PBTypeahead.Option]
    @Binding var searchText: String
    @FocusState.Binding private var isFocused: Bool
    @State private var numberOfItemsShown: [String?: Int] = [:]
    private var popoverManager = PopoverManager.shared

    public init(
        id: Int,
        title: String,
        placeholder: String = "Select",
        searchText: Binding<String>,
        options: [PBTypeahead.OptionType],
        selection: PBTypeahead.Selection,
        debounce: (time: TimeInterval, numberOfCharacters: Int) = (0, 0),
        dropdownMaxHeight: CGFloat? = nil,
        listOffset: (x: CGFloat, y: CGFloat) = (0, 0),
        isFocused: FocusState<Bool>.Binding,
        selectedOptions: Binding<[PBTypeahead.Option]>,
        noOptionsText: String = "No options",
        clearAction: (() -> Void)? = nil
    ) {
        self.id = id
        self.title = title
        self.placeholder = placeholder
        self._searchText = searchText
        self.selection = selection
        self.options = options
        self.debounce = debounce
        self.dropdownMaxHeight = dropdownMaxHeight
        self.listOffset = listOffset
        self._isFocused = isFocused
         self.clearAction = clearAction
        self.noOptionsText = noOptionsText
        self._selectedOptions = selectedOptions
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xSmall) {
            Text(title).pbFont(.caption)
                .padding(.bottom, Spacing.xxSmall)
            GridInputField(
                placeholder: placeholder,
                searchText: $searchText,
                selection: optionsSelected,
                isFocused: $isFocused,
                clearAction: { clear },
                onItemTap: { removeSelected($0) },
                onViewTap: { onViewTap }
            )
            .pbPopover(
                isPresented: $showPopover,
                id: id,
                position: .bottom(listOffset.x, listOffset.y),
                variant: .dropdown,
                refreshView: $isHovering
            ) {
                listView
            }
        }
            .onTapGesture {
                isFocused = false
            }
            .onAppear {
                focused = isFocused
                if debounce.numberOfCharacters == 0 {
                    if isFocused {
                        showPopover = true
                        reloadList
                    } else {
                        showPopover = false
                    }
                }
                setKeyboardControls
                if !selectedOptions.isEmpty {
//                    selectedIndex = options.first?.id.firstIndex(of: selectedOptions[0].id)
                }
            }
            .onChange(of: isFocused) { _, newValue in
                if newValue {
                    showPopover = true
                }
            }
            .onChange(of: selectedOptions.count) {
                reloadList
            }
            .onChange(of: hoveringIndex) {
                reloadList
            }
                    .onChange(of: showPopover) { _, newValue in
            if newValue {
                isFocused = true
                popoverManager.showPopover(for: id)
            } else {
                isFocused = false
                popoverManager.hidePopover(for: id)
            }
        }
        .onChange(of: popoverManager.isPopoverActive(for: id)) { _, newValue in
            if !newValue {
                showPopover = false
                popoverManager.hidePopover(for: id)
            }
        }
            .onChange(of: searchText, debounce: debounce) { _ in
                _ = searchResults
                reloadList
                if !searchText.isEmpty {
                    showPopover = true
                }
            }
        }
}

@MainActor
private extension PBTypeaheadTemplate {
    @ViewBuilder
    var listView: some View {
        PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
            let flat = Array(zip(flattenedResults.indices, flattenedResults))
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(flat, id: \.0) { index, element in
                            listElementView(index: index, element: element)
                                .focusable()
                                .focused($isFocused)
                                .focusEffectDisabled()
                                .onKeyPress(.upArrow, action: {
                                    if let index = hoveringIndex, index > 0 {
                                        proxy.scrollTo(index > 1 ? (index - 1) : 0)
                                    }
                                    return .handled
                                })
                                .onKeyPress(.downArrow) {
                                    if let index = hoveringIndex, index != searchResults.count-1 {
                                        proxy.scrollTo(index < searchResults.count ? (index + 1) : 0)
                                    }
                                    return .handled
                                }
                                .onAppear {
                                    hoveringIndex = 0
                                }
                        }
                    }
                }
                .scrollDismissesKeyboard(.immediately)
                .frame(maxHeight: dropdownMaxHeight)
                .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    @ViewBuilder
    func listElementView(index: Int, element: PBTypeahead.OptionType) -> some View {
        switch element {
            case .section(let title):
                sectionView(title)
            case .item(let option):
                listItemView(option: option, index: index)
            case .button(let button):
                button.padding()
        }
    }

    func sectionView(_ section: String) -> some View {
        Text(section).pbFont(.caption)
            .padding(.top)
            .padding(.leading)
    }

    func listItemView(option: PBTypeahead.Option, index: Int) -> some View {
        HStack {
            if let customView = option.customView?() {
                customView
            } else {
                Text(option.text ?? option.id)
                    .pbFont(.body, color: listTextolor(index))
            }
        }
        .padding(.horizontal, Spacing.xSmall + 4)
        .padding(.vertical, Spacing.xSmall + 4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(listBackgroundColor(index))
        .onHover(disabled: false) { hover in
            isHovering = hover
            hoveringIndex = index
        }
        .onTapGesture {
            onListSelection(index: index, option: option)
        }
    }

    var mapResults: [PBTypeahead.SectionList] {
        var array: [PBTypeahead.SectionList] = []
        var currentSection: String? = nil
        var currentOptions: [PBTypeahead.Option] = []
        for result in searchResults {
            switch result {
                case .section(let section):
                    if !currentOptions.isEmpty || currentSection != nil {
                        appendSectionToArray(
                            section: currentSection,
                            options: currentOptions,
                            to: &array
                        )
                        currentOptions = []
                    }
                    currentSection = section
                case .item(let option):
                    currentOptions.append(option)
                case .button(_): break
            }
        }
        if !currentOptions.isEmpty || currentSection != nil {
            appendSectionToArray(
                section: currentSection,
                options: currentOptions,
                to: &array
            )
        }
        return array
    }

    var flattenedResults: [PBTypeahead.OptionType] {
        var elements: [PBTypeahead.OptionType] = []
        for section in mapResults {
            if let sectionTitle = section.section {
                elements.append(.section(sectionTitle))
            }
            elements.append(contentsOf: section.items.map { .item($0) })
            if let button = section.button {
                elements.append(.button(button))
            }
        }
        return elements
    }

    private func appendSectionToArray(
        section: String?,
        options: [PBTypeahead.Option],
        to array: inout [PBTypeahead.SectionList]
    ) {
        let numberOfItems = numberOfItemsShown[section] ?? 2
        array.append(PBTypeahead.SectionList(
            section: section,
            items: Array(options.prefix(numberOfItems)),
            button: PBButton(
                variant: .link,
                title: (numberOfItems == 2) ? "View More" : "View Less",
                icon: (numberOfItems == 2) ? .fontAwesome(.chevronDown) : .fontAwesome(.chevronUp)
            ) {
                numberOfItemsShown[section] = (numberOfItems == 2) ? 4 : 2
                reloadList
            }
        ))
    }

    var searchResults: [PBTypeahead.OptionType] {
        let filteredOptions = searchText.isEmpty && debounce.numberOfCharacters == 0 ? options : options.filter {
            switch $0 {
                case .item(let item):
                    if let text = item.text {
                        return text.localizedCaseInsensitiveContains(searchText)
                    } else {
                        return item.id.localizedCaseInsensitiveContains(searchText)
                    }
                default: return true
            }
        }
        let selectedIds = Set(selectedOptions.map { $0.id })
        let filteredSelectedOptions = filteredOptions.filter { !selectedIds.contains($0.id) }
        switch selection{
            case .multiple: return filteredSelectedOptions
            case .single: return filteredOptions
        }
    }

    var optionsSelected: GridInputField.Selection {
        let optionsSelected = selectedOptions.map { value in
            if let content = value.text {
                return content
            } else {
                return value.id
            }
        }
        return selection.selectedOptions(options: optionsSelected, placeholder: placeholder)
    }

    var clear: Void {
        if let action = clearAction {
            action()
        }
        searchText = ""
        selectedOptions.removeAll()
        selectedIndex = nil
        hoveringIndex = nil
        showPopover = false
    }

    private func togglePopover() {
        showPopover.toggle()
    }

    var onViewTap: Void {
        togglePopover()
        isFocused = true
    }

    var reloadList: Void {
        isHovering.toggle()
    }

    func onListSelection(index: Int, option: PBTypeahead.Option) {
        if option.text != noOptionsText {
            switch selection {
                case .single:
                    onSingleSelection(index: index, option)
                case .multiple:
                    onMultipleSelection(option)
            }
        }
        showPopover = false
        searchText = ""
        reloadList
        isFocused = true
    }

    func onSingleSelection(index: Int, _ option: PBTypeahead.Option) {
        selectedOptions.removeAll()
        selectedOptions = [option]
        selectedIndex = index
        hoveringIndex = index
        selectedOptions.append(option)
        reloadList
    }

    func onMultipleSelection(_ option: PBTypeahead.Option) {
        selectedOptions.append(option)
        hoveringIndex = nil
        selectedIndex = nil
        reloadList
    }

    func removeSelected(_ index: Int) {
        if let selectedElementIndex = selectedOptions.indices.first(where: { $0 == index }) {
            let _ = selectedOptions.remove(at: selectedElementIndex)
            selectedIndex = nil
            hoveringIndex = 0
            reloadList
        }
    }

    func listBackgroundColor(_ index: Int?) -> Color {
        switch selection {
            case .single:
                if selectedIndex != nil, selectedIndex == index {
                    return .pbPrimary
                }
            default: break
        }
        #if os(macOS)
        return hoveringIndex == index ? .hover : .card
        #elseif os(iOS)
        return .card
        #endif
    }

    func listTextolor(_ index: Int?) -> Color {
        if selectedIndex != nil, selectedIndex == index {
            return .white
        } else {
            return .text(.default)
        }
    }

    var setKeyboardControls: Void {
        #if os(macOS)
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.keyCode == 48  { // tab
                focused = true
            }
            if event.keyCode == 36 { // return bar
                if isFocused,
                let index = hoveringIndex,
                index <= searchResults.count-1,
                let results = mapResults.first?.items,
                showPopover {
                    onListSelection(index: index, option: results[index-1])
                }
            }
            if event.keyCode == 49 { // space
                if isFocused {
                    if let index = hoveringIndex,
                       let results = mapResults.first?.items,
                        index <= results.count-1,
                        searchText.isEmpty,
                        showPopover {
                        onListSelection(index: index, option: results[index])
                    } else {
                        showPopover = true
                    }
                }
            }
            if event.keyCode == 51 { // delete
                if let lastElementIndex = selectedOptions.indices.last, isFocused, searchText.isEmpty, !selectedOptions.isEmpty {
                    removeSelected(lastElementIndex)
                }
            }
            if event.keyCode == 125 { // arrow down
                if showPopover, let index = hoveringIndex, index < searchResults.count-1 {
                    isFocused = true
                    hoveringIndex = index < searchResults.count ? (index + 1) : 0
                }
            }
            else {
                if event.keyCode == 126 { // arrow up
                    if showPopover, let index = hoveringIndex {
                        isFocused = true
                        hoveringIndex = index > 1 ? (index - 1) : 0
                    }
                }
            }
            return event
        }
        #endif
    }
}

#Preview {
    registerFonts()
    return TypeaheadCatalog()
}
