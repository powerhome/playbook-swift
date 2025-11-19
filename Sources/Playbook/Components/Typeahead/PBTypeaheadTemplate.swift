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
  private let title: String
  private let placeholder: String
  private var options: [PBTypeahead.OptionType]
  private let selection: PBTypeahead.Selection
  private let noOptionsText: String
  private let debounce: (time: TimeInterval, numberOfCharacters: Int)
  private let dropdownMaxHeight: CGFloat?
  private let clearAction: (() -> Void)?
  private var numberOfItemsToShowInSection: Int

  @State private var showDropdown: Bool = false
  @State private var hoveringIndex: Int?
  @State private var isHovering: Bool = false
  @State private var selectedIndex: Int?
  @State private var focused: Bool = false
  @State var fieldHeight: CGFloat = 48
  @Binding var selectedOptions: [PBTypeahead.Option]
  @Binding var searchText: String
  @FocusState.Binding private var isFocused: Bool
  @State private var numberOfItemsShow: [String?: Int] = [:]

  public init(
    title: String,
    placeholder: String = "Select",
    searchText: Binding<String>,
    options: [PBTypeahead.OptionType],
    selection: PBTypeahead.Selection,
    debounce: (time: TimeInterval, numberOfCharacters: Int) = (0, 0),
    dropdownMaxHeight: CGFloat? = nil,
    isFocused: FocusState<Bool>.Binding,
    selectedOptions: Binding<[PBTypeahead.Option]>,
    noOptionsText: String = "No options",
    numberOfItemsToShowInSection: Int = 2,
    clearAction: (() -> Void)? = nil
  ) {
    self.title = title
    self.placeholder = placeholder
    self._searchText = searchText
    self.selection = selection
    self.options = options
    self.debounce = debounce
    self.dropdownMaxHeight = dropdownMaxHeight
    self._isFocused = isFocused
    self.clearAction = clearAction
    self.noOptionsText = noOptionsText
    self.numberOfItemsToShowInSection = numberOfItemsToShowInSection
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
      .frameReader { fieldHeight = $0.height }
      .globalPosition(alignment: .top, top: fieldHeight) {
        ZStack {
          if showDropdown {
            listView
          }
        }
      }
    }
    .onTapGesture {
      isFocused = false
    }
    .onAppear {
      focused = isFocused
      if debounce.numberOfCharacters == 0 {
        if isFocused {
          showDropdown = true
          reloadList
        } else {
          showDropdown = false
        }
      }
      setKeyboardControls
    }
    .onChange(of: isFocused) {
      showDropdown = true
    }
    .onChange(of: selectedOptions.count) {
      reloadList
    }
    .onChange(of: hoveringIndex) {
      reloadList
    }
    .onChange(of: searchText, debounce: debounce) { _ in
      _ = searchResults
      reloadList
      if !searchText.isEmpty {
        showDropdown = true
      }
    }
  }
}

@MainActor
private extension PBTypeaheadTemplate {
  @ViewBuilder
  var listView: some View {
    PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
      let flat = Array(zip(searchResults.indices, searchResults))
      ScrollViewReader { proxy in
        ScrollView {
          VStack(alignment: .leading, spacing: 0) {
            ForEach(flat, id: \.0) { index, element in
              listElementView(index: index, element: element)
                .onAppear {
                  hoveringIndex = 0
                }
            }
          }
        }
        .scrollDismissesKeyboard(.never)
        .scrollIndicators(.hidden)
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

private extension PBTypeaheadTemplate {
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

  //    var mapResults: [PBTypeahead.SectionList] {
  //        var array: [PBTypeahead.SectionList] = []
  //        var currentSection: String? = nil
  //        var currentOptions: [PBTypeahead.Option] = []
  //        var currentButton: PBButton? = nil
  //        var buttonAction: () -> Void = {}
  //
  //        for result in searchResults {
  //            switch result {
  //                case .section(let section):
  //                    buttonAction = {  if numberOfItemsShow[section] == numberOfItemsToShowInSection {
  //                        numberOfItemsShow[section] = numberOfItemsToShowInSection*2
  //                    } else {
  //                        numberOfItemsShow[section] = numberOfItemsToShowInSection
  //                    }
  //                        reloadList
  //                    }
  //
  //                    if !currentOptions.isEmpty || currentSection != nil {
  //                        appendSectionToArray(
  //                            section: currentSection,
  //                            options: currentOptions,
  //                            button: currentButton,
  //                            to: &array
  //                        )
  //                        currentOptions = []
  //                    }
  //                    currentSection = section
  //                case .item(let option):
  //                    currentOptions.append(option)
  //                case .button(let button):
  //                    currentButton = PBButton(
  //                        fullWidth: button.fullWidth,
  //                        variant: button.variant,
  //                        size: button.size,
  //                        shape: button.shape,
  //                        title: currentSection,
  //                        icon: button.icon,
  //                        iconPosition: button.iconPosition,
  //                        isLoading: button.$isLoading,
  //                        action: buttonAction
  //                    )
  //            }
  //        }
  //        if currentOptions.isEmpty  {
  //            appendSectionToArray(
  //                section: currentSection,
  //                options: currentOptions,
  //                button: currentButton,
  //                to: &array
  //            )
  //        }
  //        return array
  //    }

  //    var flattenedResults: [PBTypeahead.OptionType] {
  //        var elements: [PBTypeahead.OptionType] = []
  //        for section in mapResults {
  //            if let sectionTitle = section.section {
  //                elements.append(.section(sectionTitle))
  //            }
  //            elements.append(contentsOf: section.items.map { .item($0) })
  //            if let button = section.button {
  //                elements.append(.button(button))
  //            }
  //        }
  //        return elements
  //    }

  private func appendSectionToArray(
    section: String?,
    options: [PBTypeahead.Option],
    button: PBButton?,
    to array: inout [PBTypeahead.SectionList]
  ) {
    let numberOfItems = numberOfItemsShow[section] ?? numberOfItemsToShowInSection
    array.append(PBTypeahead.SectionList(
      section: section,
      items: Array(options.prefix(numberOfItems)),
      button: button
    ))
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
    showDropdown = false
  }

  private func toggleDropdown() {
    showDropdown.toggle()
  }

  var onViewTap: Void {
    toggleDropdown()
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
    showDropdown = false
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

  var setKeyboardControls: Void {
    #if os(macOS)
    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
      if event.keyCode == 48  { // tab
        focused = true
      }
      if event.keyCode == 36 { // return bar
        if isFocused,
           let index = hoveringIndex,
           index <= searchResults.count-1 {
          switch searchResults[index] {
          case .item(let option):
            onListSelection(index: index, option: option)
          default: break
          }
        }
      }
      if event.keyCode == 49 { // space
        if isFocused {
          if let index = hoveringIndex,
             index <= searchResults.count-1,
             searchText.isEmpty,
             showDropdown {
            switch searchResults[index] {
            case .item(let option):
              onListSelection(index: index, option: option)
            default: break
            }
          } else {
            showDropdown = true
          }
        }
      }
      if event.keyCode == 51 { // delete
        if let lastElementIndex = selectedOptions.indices.last, isFocused, searchText.isEmpty, !selectedOptions.isEmpty {
          removeSelected(lastElementIndex)
        }
      }
      if event.keyCode == 125 { // arrow down
        if showDropdown, let index = hoveringIndex, index < searchResults.count-1 {
          isFocused = true
          hoveringIndex = index < searchResults.count ? (index + 1) : 0
        }
      }
      else {
        if event.keyCode == 126 { // arrow up
          if showDropdown, let index = hoveringIndex {
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

//#Preview {
//    registerFonts()
//    return TypeaheadCatalog()
//}
