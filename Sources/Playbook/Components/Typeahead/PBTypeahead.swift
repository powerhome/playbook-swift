//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTypeahead.swift
//

import SwiftUI

public struct PBTypeahead<Content: View>: View {
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
    private let noOptionsText: String
    @State private var showList: Bool = false
    @State private var isCollapsed = false
    @State private var hoveringIndex: Int?
    @State private var hoveringOption: Option?
    @State private var isHovering: Bool = false
    @State private var contentSize: CGSize = .zero
    @State private var selectedIndex: Int?
    @State private var focused: Bool = false
    @Binding var options: [Option]
    @Binding var selectedOptions: [Option]
    @Binding var searchText: String
    @FocusState.Binding private var isFocused: Bool

    public init(
        id: Int,
        title: String,
        placeholder: String = "Select",
        searchText: Binding<String>,
        options: Binding<[Option]>,
        selection: Selection,
        debounce: (time: TimeInterval, numberOfCharacters: Int) = (0, 0),
        dropdownMaxHeight: CGFloat? = nil,
        listOffset: (x: CGFloat, y: CGFloat) = (0, 0),
        isFocused: FocusState<Bool>.Binding,
        selectedOptions: Binding<[Option]>,
        clearAction: (() -> Void)? = nil,
        noOptionsText: String = "No options"
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
        .onChange(of: hoveringIndex) { index in
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
private extension PBTypeahead {
    @ViewBuilder
    var listView: some View {
        PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(zip(searchResults.indices, searchResults)), id: \.0) { index, result in
                        HStack {
                            if result.0 == noOptionsText {
                                emptyView
                            } else {
                                if let customView = result.1?.1?() {
                                    customView
                                } else {
                                    Text(result.1?.0 ?? result.0)
                                        .pbFont(.body, color: listTextolor(index))
                                }
                            }
                        }
                        .padding(.horizontal, Spacing.xSmall + 4)
                        .padding(.vertical, Spacing.xSmall + 4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(listBackgroundColor(index))
                        .onHover(disabled: false) { hover in
                            isHovering = hover
                            hoveringIndex = index
                            hoveringOption = result
                        }
                        .onTapGesture {
                            if result.0 != "No Options" {
                                onListSelection(index: index, option: result)
                            }
                        }
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .frame(maxHeight: dropdownMaxHeight)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .transition(.opacity)
    }

    var emptyView: some View {
        HStack {
            Spacer()
            Text(noOptionsText)
                .pbFont(.body, color: .text(.light))
            Spacer()
        }
    }

    var searchResults: [Option] {
        let filteredOptions = searchText.isEmpty && debounce.numberOfCharacters == 0 ? options : options.filter {
            if let text = $0.1?.0 {
                return text.localizedCaseInsensitiveContains(searchText)
            } else {
                return $0.0.localizedCaseInsensitiveContains(searchText)
            }
        }
        let selectedIds = Set(selectedOptions.map { $0.0 })
        let filteredSelectedOptions = filteredOptions.filter { !selectedIds.contains($0.0) }
        switch selection{
            case .multiple: return filteredSelectedOptions.isEmpty ? [(noOptionsText, nil)] : filteredSelectedOptions
            case .single: return filteredOptions.isEmpty ? [(noOptionsText, nil)] : filteredOptions
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
        selectedOptions = []
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

    func onListSelection(index: Int, option: Option) {
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

    func onSingleSelection(index: Int, _ option: Option) {
        selectedOptions = [option]
        selectedIndex = index
        hoveringIndex = index
    }

    func onMultipleSelection(_ option: Option) {
        selectedOptions.append(option)
        hoveringIndex = nil
        selectedIndex = nil
    }

    func removeSelected(_ index: Int) {
        if let selectedElementIndex = selectedOptions.indices.first(where: { $0 == index }) {
            let _ = selectedOptions.remove(at: selectedElementIndex)
            selectedIndex = nil
        }
    }

    func listBackgroundColor(_ index: Int?) -> Color {
        switch selection {
            case .single:
                if selectedIndex != nil, selectedIndex == index, (selectedOptions.firstIndex(where: { $0.0 == options[index ?? 0].0 }) != nil) {
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


public extension PBTypeahead {
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
