//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTypeaheadTemplate.swift
//

import SwiftUI

struct SectionList: Identifiable {
    let id: UUID = UUID()
    let section: String?
    let items: [PBTypeahead.Option]
    let button: PBButton?
    static func == (lhs: SectionList, rhs: SectionList) -> Bool { lhs.id == rhs.id }
}

enum ListElement: Identifiable {
    case section(String)
    case item(PBTypeahead.Option)
    case button(PBButton)

    var id: UUID {
        switch self {
        case .section(let title):
            return UUID(uuidString: title.hashValue.description) ?? UUID()
        case .item(let option):
                return UUID(uuidString: option.id) ?? UUID()
        case .button(let button):
                return UUID(uuidString: button.title ?? "id") ?? UUID()
        }
    }
}


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

    @State private var hoveringIndex: (Int?, String?)
    @State private var isHovering: Bool = false
    @State private var contentSize: CGSize = .zero
    @State private var selectedIndex: Int?
    @State private var focused: Bool = false
    @State var numberOfItemsShown: [String?: Int] = [:]
    @Binding var selectedOptions: [PBTypeahead.Option]
    @Binding var searchText: String
    @FocusState.Binding private var isFocused: Bool
    @State private var popoverManager = PopoverManager.shared

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
        self.noOptionsText = noOptionsText
        self.clearAction = clearAction
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
            .sizeReader { contentSize = $0 }
            .pbPopover(
                isPresented: showPopover,
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
                        popoverManager.showPopover(for: id)
                        reloadList
                    } else {
                        popoverManager.hidePopover(for: id)
                    }
                }
                setKeyboardControls
                if !selectedOptions.isEmpty {
//                    selectedIndex = options.first?.id.firstIndex(of: selectedOptions[0].id)
                }
            }
            .onChange(of: isFocused) { _, newValue in
                if newValue {
                    popoverManager.showPopover(for: id)
                }
            }
            .onChange(of: selectedOptions.count) {
                reloadList
            }
            .onChange(of: hoveringIndex.0) {
                reloadList
            }
            .onChange(of: popoverManager.isPopoverActive(for: id)) { _, newValue in
                if newValue {
                    isFocused = true
                }
            }
            .onChange(of: searchText, debounce: debounce) { _ in
                _ = searchResults
                reloadList
                if !searchText.isEmpty {
                    popoverManager.showPopover(for: id)
                }
            }
        }
}

@MainActor
private extension PBTypeaheadTemplate {
    var showPopover: Binding<Bool> {
        .init(
            get: {
                popoverManager.isPopoverActive(for: id)
            },
            set: { isActive in
                if isActive {
                    popoverManager.showPopover(for: id)
                } else {
                    popoverManager.hidePopover(for: id)
                }
            }
        )
    }

    @ViewBuilder
    var listView: some View {
        PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
            let flat = Array(zip(flattenedResults.indices, flattenedResults))
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Group {
                        ForEach(flat, id: \.0) { index, element in
                            listElementView(index: index, element: element)
                        }
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .frame(maxHeight: dropdownMaxHeight)
            .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .top)
    }

    @ViewBuilder
    func listElementView(index: Int, element: ListElement) -> some View {
        switch element {
            case .section(let title):
                sectionView(title)
            case .item(let option):
                listItemView(item: option, index: index)
            case .button(let button):
                button.padding()
        }
    }

    func sectionView(_ section: String) -> some View {
        Text(section).pbFont(.caption)
            .padding(.top)
            .padding(.leading)
    }

    func listItemView(item: PBTypeahead.Option, index: Int) -> some View {
        HStack {
            if let customView = item.customView?() {
                customView
            } else {
                Text(item.text ?? item.id)
                    .pbFont(.body, color: listTextolor(index))
            }
        }
        .padding(.horizontal, Spacing.xSmall + 4)
        .padding(.vertical, Spacing.xSmall + 4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(listBackgroundColor(index, section: ""))
        .onHover(disabled: false) { hover in
            isHovering = hover
            hoveringIndex = (index, "")
        }
        .onTapGesture {
            onListSelection(index: index, section: "", option: item)
        }
    }

    var mapResults: [SectionList] {
        var array: [SectionList] = []
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

    var flattenedResults: [ListElement] {
        var elements: [ListElement] = []

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
        to array: inout [SectionList]
    ) {
        let numberOfItems = numberOfItemsShown[section] ?? 2
        array.append(SectionList(
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
                case .section(_):
                    return true
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
        hoveringIndex = (nil, nil)
        popoverManager.hidePopover(for: id)
    }

    var setKeyboardControls: Void {
        #if os(macOS)
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.keyCode == 48  { // tab
                focused = true
            }
            if event.keyCode == 36 { // return bar
                if let index = hoveringIndex.0,
                   let section = hoveringIndex.1,
                   let results = mapResults.first?.items,
                   index <= results.count-1, isFocused {
                    onListSelection(index: index, section: section, option: results[index])
                }
            }
            if event.keyCode == 49 { // space
                if isFocused {
                    if let index = hoveringIndex.0,
                       let section = hoveringIndex.1,
                       let results = mapResults.first?.items,
                        index <= results.count-1, searchText.isEmpty {
                        onListSelection(index: index, section: section, option: results[index])
                    } else {
                        popoverManager.showPopover(for: id)
                    }
                }
            }
            if event.keyCode == 51 { // delete
                if let lastElementIndex = selectedOptions.indices.last, isFocused, searchText.isEmpty, !selectedOptions.isEmpty {
                    removeSelected(lastElementIndex)
                }
            }
            if event.keyCode == 125 { // arrow down
                if isFocused {
                    if let index = hoveringIndex.0 {
                        hoveringIndex.0 = index < searchResults.count ? (index + 1) : 0
                    } else {
                        hoveringIndex.0 = 0
                    }
                }
            }
            else {
                if event.keyCode == 126 { // arrow up
                    if isFocused, let index = hoveringIndex.0 {
                        hoveringIndex.0 = index > 1 ? (index - 1) : 0
                    }
                }
            }
            return event
        }
        #endif
    }

    private func togglePopover() {
        if popoverManager.isPopoverActive(for: id) {
            popoverManager.hidePopover(for: id)
        } else {
            popoverManager.showPopover(for: id)
        }
    }

    var onViewTap: Void {
        togglePopover()
        isFocused = true
    }

    var reloadList: Void {
        isHovering.toggle()
        popoverManager.update(with: id)
    }

    func onListSelection(index: Int, section: String?, option: PBTypeahead.Option) {
        if option.text != noOptionsText {
            switch selection {
                case .single:
                    onSingleSelection(index: index, section: section, option)
                case .multiple:
                    onMultipleSelection(index: index, section: section, option)
            }
        }
        popoverManager.hidePopover(for: id)
        searchText = ""
        reloadList
        isFocused = true
    }

    func onSingleSelection(index: Int, section: String?, _ option: PBTypeahead.Option) {
        selectedOptions.removeAll()
        if hoveringIndex.0 == index && hoveringIndex.1 == section {
            selectedOptions.append(option)
        }
        selectedIndex = index
        hoveringIndex = (index, section)
    }

    func onMultipleSelection(index: Int, section: String?, _ option: PBTypeahead.Option) {
        if hoveringIndex.0 == index && hoveringIndex.1 == section {
            selectedOptions.append(option)
        }
        hoveringIndex = (index, section)
        selectedIndex = nil
    }

    func removeSelected(_ index: Int) {
        if let selectedElementIndex = selectedOptions.indices.first(where: { $0 == index }) {
            _ = selectedOptions.remove(at: selectedElementIndex)
            selectedIndex = nil
        }
    }

    func listBackgroundColor(_ index: Int?, section: String?) -> Color {
        switch selection {
            case .single:
                if selectedIndex != nil, selectedIndex == index {
                    return .pbPrimary
                }
            default: break
        }
        #if os(macOS)
        return hoveringIndex.0 == index && hoveringIndex.1 == section ? .hover : .card
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
}

#Preview {
    registerFonts()
    return TypeaheadCatalog()
}
