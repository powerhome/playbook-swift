//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTypeaheadTemplate.swift
//

import SwiftUI

public struct PBTypeaheadTemplate<Content: View>: View {
    public typealias Option = (String, (String, (() -> Content?)?)?)
    private let id: Int
    private let title: String
    private let placeholder: String
    private let selection: Selection
    private let debounce: (time: TimeInterval, numberOfCharacters: Int)
    private let dropdownMaxHeight: CGFloat?
    private let listOffset: (x: CGFloat, y: CGFloat)
    private let popoverManager = PopoverManager()
    private let clearAction: (() -> Void)?
    @State private var showList: Bool = false
    @State private var isCollapsed = false
    @State private var hoveringIndex: (Int?, String?)
    @State private var hoveringOption: Option?
    @State private var isHovering: Bool = false
    @State private var contentSize: CGSize = .zero
    @State private var selectedIndex: Int?
    @State private var focused: Bool = false
    @State var numberOfItemsShown: [String?: Int] = [:]
    @Binding var options: [OptionType]
    @Binding var selectedOptions: [Option]
    @Binding var searchText: String
    @FocusState.Binding private var isFocused: Bool

    public init(
        id: Int,
        title: String,
        placeholder: String = "Select",
        searchText: Binding<String>,
        options: Binding<[OptionType]>,
        selection: Selection,
        debounce: (time: TimeInterval, numberOfCharacters: Int) = (0, 0),
        dropdownMaxHeight: CGFloat? = nil,
        listOffset: (x: CGFloat, y: CGFloat) = (0, 0),
        isFocused: FocusState<Bool>.Binding,
        selectedOptions: Binding<[Option]> = .constant([]),
        clearAction: (() -> Void)? = nil
    ) {
        self.id = id
        self.title = title
        self.placeholder = placeholder
        self._searchText = searchText
        self.selection = selection
        self._options = options
        self.debounce = debounce
        self.dropdownMaxHeight = dropdownMaxHeight
        self.listOffset = listOffset
        self._isFocused = isFocused
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
                isPresented: $showList,
                id: id,
                position: .bottom(listOffset.x, listOffset.y),
                variant: .dropdown,
                refreshView: $isHovering
            ) {
                listView
            }
            .onTapGesture {
                isFocused = false
            }
        }
        .onAppear {
            focused = isFocused
            if debounce.numberOfCharacters == 0 {
                showList = isFocused
            }
            setKeyboardControls
        }
        .onChange(of: isFocused) { newValue in
            Timer.scheduledTimer(withTimeInterval: 0.03, repeats: false) { _ in
                showList = newValue
            }
        }
        .onChange(of: searchText, debounce: debounce) { _ in
            _ = searchResults
            reloadList
        }
        .onChange(of: searchResults.count) { _ in
            reloadList
        }
        .onChange(of: contentSize) { _ in
            reloadList
        }
        .onChange(of: hoveringIndex.0) { _ in
            reloadList
        }
        .onChange(of: searchText, debounce: debounce) { _ in
            if !searchText.isEmpty {
                showList = true
            }
        }
    }
}

@MainActor
private extension PBTypeaheadTemplate {
    @ViewBuilder
    var listView: some View {
        PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(mapResults, id: \.0) { result in
                        if let section = result.0 {
                            sectionView(section)
                        }
                        ForEach(Array(zip(result.1.indices, result.1)), id: \.0) { index, item in
                            listItemView(item: item, index: index, for: result.0)
                        }
                        result.2.padding()
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .frame(maxHeight: dropdownMaxHeight)
            .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .top)
    }

    func sectionView(_ section: String) -> some View {
        Text(section).pbFont(.caption)
            .padding(.top)
            .padding(.leading)
    }

    func listItemView(item: Option, index: Int, for section: String?) -> some View {
        HStack {
            if let customView = item.1?.1?() {
                customView
            } else {
                Text(item.1?.0 ?? item.0)
                    .pbFont(.body, color: listTextolor(index))
            }
        }
        .padding(.horizontal, Spacing.xSmall + 4)
        .padding(.vertical, Spacing.xSmall + 4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(listBackgroundColor(index, section: section))
        .onHover(disabled: false) { hover in
            isHovering = hover
            hoveringIndex = (index, section)
            hoveringOption = item
        }
        .onTapGesture {
            onListSelection(index: index, section: section, option: item)
        }
    }

    var mapResults: [(String?, [Option], PBButton)] {
        var array: [(String?, [Option], PBButton)] = []
        var currentSection: String? = nil
        var currentOptions: [Option] = []
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

    private func appendSectionToArray(
        section: String?,
        options: [Option],
        to array: inout [(String?, [Option], PBButton)]
    ) {
        let numberOfItems = numberOfItemsShown[section] ?? 2
        array.append((
            section,
            Array(options.prefix(numberOfItems)),
            PBButton(
                variant: .link,
                title: (numberOfItems == 2) ? "View More" : "View Less",
                icon: (numberOfItems == 2) ? .fontAwesome(.chevronDown) : .fontAwesome(.chevronUp)
            ) {
                numberOfItemsShown[section] = (numberOfItems == 2) ? 4 : 2
                reloadList
            }
        ))
    }

    var searchResults: [OptionType] {
        let filteredOptions = searchText.isEmpty && debounce.numberOfCharacters == 0 ? options : options.filter {
            switch $0 {
                case .item(let item):
                    if let text = item.1?.0 {
                        return text.localizedCaseInsensitiveContains(searchText)
                    } else {
                        return item.0.localizedCaseInsensitiveContains(searchText)
                    }
                case .section(_):
                    return true
            }
        }
        let selectedIds = Set(selectedOptions.map { $0.0 })
        let filteredSelectedOptions = filteredOptions.filter { !selectedIds.contains($0.id) }
        switch selection{
            case .multiple: return filteredSelectedOptions
            case .single: return filteredOptions
        }
    }

    var optionsSelected: GridInputField.Selection {
        let optionsSelected = selectedOptions.map { value in
            if let content = value.1 {
                return content.0
            } else {
                return value.0
            }
        }
        return selection.selectedOptions(options: optionsSelected, placeholder: placeholder)
    }

    var clear: Void {
        if let action = clearAction {
            clearText
            action()
        } else {
            clearText
        }
    }

    var clearText: Void {
        searchText = ""
        selectedOptions.removeAll()
        selectedIndex = nil
        hoveringIndex = (nil, nil)
        showList = false
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
                    let results = mapResults.first?.1,
                   index <= results.count-1,
                    showList {
                    onListSelection(index: index, section: section, option: results[index])
                }
            }
            if event.keyCode == 49 { // space
                if isFocused {
                    if let index = hoveringIndex.0,
                       let section = hoveringIndex.1,
                        let results = mapResults.first?.1,
                        index <= results.count-1,
                        showList, searchText.isEmpty {
                        onListSelection(index: index, section: section, option: results[index])
                    } else {
                        showList = true
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
                    if let index = hoveringIndex.0, let section = hoveringIndex.1 {
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

    var onViewTap: Void {
        showList.toggle()
        isFocused = true
    }

    var reloadList: Void {
        if showList {
            isHovering.toggle()
        }
    }

    func onListSelection(index: Int, section: String?, option: Option) {
        if showList {
            switch selection {
                case .single:
                    onSingleSelection(index: index, section: section, option)
                case .multiple:
                    onMultipleSelection(index: index, section: section, option)
            }
        }
        showList = false
        searchText = ""
    }

    func onSingleSelection(index: Int, section: String?, _ option: Option) {
        selectedOptions.removeAll()
        if hoveringIndex.0 == index && hoveringIndex.1 == section {
            selectedOptions.append(option)
        }
        selectedIndex = index
        hoveringIndex = (index, section)
    }

    func onMultipleSelection(index: Int, section: String?, _ option: Option) {
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

public extension PBTypeaheadTemplate {
    enum Selection {
        case single, multiple(variant: GridInputField.Selection.Variant)

        func selectedOptions(options: [String], placeholder: String) -> GridInputField.Selection {
            switch self {
                case .single: return .single(options.first)
                case .multiple(let variant): return .multiple(variant, options)
            }
        }
    }
}

public extension PBTypeaheadTemplate {
    enum OptionType: Identifiable {
        public var id: String {
            switch self {
                case .section(let str):
                    return str
                case .item(let item):
                    return item.0
            }
        }
        case section(String)
        case item(PBTypeaheadTemplate.Option)
    }
}

#Preview {
    registerFonts()
    return TypeaheadCatalog()
}
