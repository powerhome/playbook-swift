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
    public enum OptionType: Identifiable {
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

    public typealias Option = (String, (String, (() -> Content?)?)?)
    private let id: Int
    private let title: String
    private let placeholder: String
    private let selection: Selection
    private let debounce: (time: TimeInterval, numberOfCharacters: Int)
    private let dropdownMaxHeight: CGFloat?
    private let listOffset: (x: CGFloat, y: CGFloat)
    private let popoverManager = PopoverManager()
    private let onSelection: (([OptionType]) -> Void)?
    private let clearAction: (() -> Void)?
    @State private var numberOfLoadedItems: Int = 6
    @State private var showList: Bool = false
    @State private var isCollapsed = false
    @State private var hoveringIndex: Int?
    @State private var hoveringOption: Option?
    @State private var isHovering: Bool = false
    @State private var contentSize: CGSize = .zero
    @State private var selectedIndex: Int?
    @State private var selectedOptions: [OptionType] = []
    @State private var focused: Bool = false
    @Binding var options: [OptionType]
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
        onSelection: @escaping (([OptionType]) -> Void),
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
        self.onSelection = onSelection
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
        .onChange(of: hoveringIndex) { _ in
            reloadList
        }
        .onChange(of: numberOfLoadedItems) { _ in
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
    func listItemView(item: Option, index: Int) -> some View {
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
        .background(listBackgroundColor(index))
        .onHover(disabled: false) { hover in
            isHovering = hover
            hoveringIndex = index
            hoveringOption = item
        }
        .onTapGesture {
//            onListSelection(index: index, option: optionType)
        }
    }

    var mapResults: [(String?, [Option])] {
        var array: [(String?, [Option])] = []
        var currentSection: String? = nil
        var currentOptions: [Option] = []

        for result in searchResults {
            switch result {
            case .section(let section):
                if !currentOptions.isEmpty || currentSection != nil {
                    array.append((currentSection, currentOptions))
                    currentOptions = []
                }
                currentSection = section

            case .item(let option):
                currentOptions.append(option)
            }
        }
        // Append the last section if it has items
        if !currentOptions.isEmpty || currentSection != nil {
            array.append((currentSection, currentOptions))
        }

        return array
    }


    @ViewBuilder
    var listView: some View {
        PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    

                    ForEach(mapResults , id: \.0) { result in


                        Text(result.0 ?? "").pbFont(.caption)
                                    .padding(.top)
                                    .padding(.leading)



                        ForEach(Array(zip(result.1.indices, result.1)), id: \.0) { index, item in
                            listItemView(item: item, index: index)
                        }

                    }








//                    ForEach(Array(zip(searchResults.indices, searchResults)).prefix(numberOfLoadedItems), id: \.0) { index, result in
//                        switch result {
//                            case .section(let section):
//                                Text(section).pbFont(.caption)
//                                    .padding(.top)
//                                    .padding(.leading)
//                            case .item(let item): listItemView(item: item, index: index, optionType: result)
//                        }
//                    }
//                    PBButton(variant: .link, title: "View More") {
//                        numberOfLoadedItems += 1
//                    }
//                    .padding()


                }
            }
            .scrollDismissesKeyboard(.immediately)
            .frame(maxHeight: dropdownMaxHeight)
            .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .top)
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
        let selectedIds = Set(selectedOptions.map { $0.id })
        let filteredSelectedOptions = filteredOptions.filter { !selectedIds.contains($0.id) }
        switch selection{
            case .multiple: return filteredSelectedOptions
            case .single: return filteredOptions
        }
    }

    var optionsSelected: GridInputField.Selection {
        let optionsSelected = selectedOptions.map { value in
            switch value {
                case .item(let item):
                    if let content = item.1 {
                        return content.0
                    } else {
                        return item.0
                    }
                default: return ""
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
        onSelection?([])
        selectedIndex = nil
        hoveringIndex = nil
        showList = false
    }

    var setKeyboardControls: Void {
        #if os(macOS)
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.keyCode == 48  { // tab
                focused = true
            }
            if event.keyCode == 36 { // return bar
                if let index = hoveringIndex, index <= searchResults.count-1, showList {
                    onListSelection(index: index, option: searchResults[index])
                }
            }
            if event.keyCode == 49 { // space
                if isFocused {
                    if let index = hoveringIndex, index <= searchResults.count-1, showList, searchText.isEmpty {
                        onListSelection(index: index, option: searchResults[index])
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
                    if let index = hoveringIndex {
                        hoveringIndex = index < searchResults.count ? (index + 1) : 0
                    } else {
                        hoveringIndex = 0
                    }
                }
            }
            else {
                if event.keyCode == 126 { // arrow up
                    if isFocused, let index = hoveringIndex {
                        hoveringIndex = index > 1 ? (index - 1) : 0
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

    func onListSelection(index: Int, option: OptionType) {
        if showList {
            switch selection {
                case .single:
                    onSingleSelection(index: index, option)
                case .multiple:
                    onMultipleSelection(option)
            }
        }
        showList = false
        searchText = ""
    }

    func onSingleSelection(index: Int, _ option: OptionType) {
        selectedOptions.removeAll()
        selectedOptions.append(option)
        selectedIndex = index
        hoveringIndex = index
        onSelection?(selectedOptions)
    }

    func onMultipleSelection(_ option: OptionType) {
        selectedOptions.append(option)
        onSelection?(selectedOptions)
        hoveringIndex = nil
        selectedIndex = nil
    }

    func removeSelected(_ index: Int) {
        if let selectedElementIndex = selectedOptions.indices.first(where: { $0 == index }) {
            let selectedElement = selectedOptions.remove(at: selectedElementIndex)
            onSelection?(selectedOptions)
            selectedIndex = nil
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

#Preview {
    registerFonts()
    return TypeaheadCatalog()
}
