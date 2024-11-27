//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTypeahead.swift
//

import SwiftUI

public struct PBTypeahead: View {
    private let id: Int
    private let title: String
    private let placeholder: String
    private let options: [PBTypeahead.Option]
    private let selection: PBTypeahead.Selection
    private let noOptionsText: String
    private let debounce: (time: TimeInterval, numberOfCharacters: Int)
    private let dropdownMaxHeight: CGFloat?
    private let listOffset: (x: CGFloat, y: CGFloat)
    private let clearAction: (() -> Void)?

    @State private var hoveringIndex: Int?
    @State private var hoveringOption: PBTypeahead.Option?
    @State private var isHovering: Bool = false
    @State private var selectedIndex: Int?
    @State private var focused: Bool = false
    @Binding var selectedOptions: [PBTypeahead.Option]
    @Binding var searchText: String
    @FocusState.Binding private var isFocused: Bool
    @ObservedObject private var popoverManager: PopoverManager

    public init(
        id: Int,
        title: String,
        placeholder: String = "Select",
        searchText: Binding<String>,
        options: [PBTypeahead.Option],
        selection: PBTypeahead.Selection,
        debounce: (time: TimeInterval, numberOfCharacters: Int) = (0, 0),
        dropdownMaxHeight: CGFloat? = nil,
        listOffset: (x: CGFloat, y: CGFloat) = (0, 0),
        isFocused: FocusState<Bool>.Binding,
        selectedOptions: Binding<[PBTypeahead.Option]>,
        popoverManager: PopoverManager,
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
        self.popoverManager = popoverManager
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
                isPresented: Binding(
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
                ),
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
                } else {
                    popoverManager.hidePopover(for: id)
                }
            }
            setKeyboardControls
            if !selectedOptions.isEmpty {
                selectedIndex = options.firstIndex(of: selectedOptions[0])
            }
        }
        .onChange(of: isFocused) { newValue in
            if newValue {
                popoverManager.showPopover(for: id)
            }
        }
        .onChange(of: selectedOptions.count) { _ in
            reloadList
        }
        .onChange(of: hoveringIndex) { index in
            reloadList
        }
        .onChange(of: popoverManager.isPopoverActive(for: id)) { newValue in
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
private extension PBTypeahead {
    private func togglePopover() {
        if popoverManager.isPopoverActive(for: id) {
            popoverManager.hidePopover(for: id)
        } else {
            popoverManager.showPopover(for: id)
        }
    }

    @ViewBuilder
    var listView: some View {
        PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(Array(zip(searchResults.indices, searchResults)), id: \.0) { index, result in
                            if #available(iOS 17.0, *), #available(macOS 14.0, *) {
                                listItemView(index: index, option: result)
                                    .focusable()
                                    .focused($isFocused)
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
                                        isFocused = true
                                        hoveringIndex = 0
                                    }
                            } else {
                                listItemView(index: index, option: result)
                                    .focused($isFocused)
                                    .onAppear {
                                        isFocused = true
                                        hoveringIndex = 0
                                    }
                            }
                        }
                    }
                }
                .scrollDismissesKeyboard(.immediately)
                .frame(maxHeight: dropdownMaxHeight)
                .fixedSize(horizontal: false, vertical: true)
            }
        }
        .onAppear {
            isFocused = true
        }
    }

    func listItemView(index: Int, option: PBTypeahead.Option) -> some View {
        HStack {
            if option.text == noOptionsText {
                emptyView
            } else {
                Group {
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
                    hoveringOption = option
                }
                .onTapGesture {
                    onListSelection(index: index, option: option)
                }
            }
        }
    }

    var emptyView: some View {
        HStack {
            Spacer()
            Text(noOptionsText)
                .pbFont(.body, color: .text(.light))
            Spacer()
        }
        .padding(.horizontal, Spacing.xSmall + 4)
        .padding(.vertical, Spacing.xSmall + 4)
    }

    var searchResults: [PBTypeahead.Option] {
        let filteredOptions = searchText.isEmpty && debounce.numberOfCharacters == 0 ? options : options.filter {
            if let text = $0.text {
                return text.localizedCaseInsensitiveContains(searchText)
            } else {
                return $0.id.localizedCaseInsensitiveContains(searchText)
            }
        }
        let selectedIds = Set(selectedOptions.map { $0.id })
        let filteredSelectedOptions = filteredOptions.filter { !selectedIds.contains($0.id) }
        switch selection{
            case .multiple: return filteredSelectedOptions.isEmpty ? [PBTypeahead.Option(id: "", text: noOptionsText, customView: nil)] : filteredSelectedOptions
            case .single: return filteredOptions.isEmpty ? [PBTypeahead.Option(id: "", text: noOptionsText, customView: nil)] : filteredOptions
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
        selectedOptions = []
        selectedIndex = nil
        hoveringIndex = nil
        popoverManager.hidePopover(for: id)    }

    var onViewTap: Void {
        togglePopover()
        isFocused = true
    }

    var reloadList: Void {
        isHovering.toggle()
        popoverManager.update(with: id)
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
        popoverManager.hidePopover(for: id)
        searchText = ""
        reloadList

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
            hoveringIndex = nil
        }
        reloadList
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
                if isFocused, let index = hoveringIndex, index <= searchResults.count-1 {
                    onListSelection(index: index, option: searchResults[index])
                }
            }
            if event.keyCode == 49 { // space
                if isFocused {
                    if let index = hoveringIndex, index <= searchResults.count-1, searchText.isEmpty {
                        onListSelection(index: index, option: searchResults[index])
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
                if popoverManager.isPopoverActive(for: id), let index = hoveringIndex, index < searchResults.count-1 {
                    isFocused = true
                    hoveringIndex = index < searchResults.count ? (index + 1) : 0
                }
            }
            else {
                if event.keyCode == 126 { // arrow up
                    if popoverManager.isPopoverActive(for: id), let index = hoveringIndex {
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
