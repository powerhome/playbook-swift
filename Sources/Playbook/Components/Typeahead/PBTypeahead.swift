//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTypeahead.swift
//

import SwiftUI

@available(iOS 17.0, *)
@available(macOS 14.0, *)
public struct PBTypeahead<Content: View>: View {
  typealias Option = (String, Content?)
  private let title: String
  private let placeholder: String
  private let variant: WrappedInputField.Variant
  private let selection: Selection
  private let clearAction: (() -> Void)?
  @State private var options: [Option] = []
  @State private var selectedOptions: [Option] = []
  @State private var showList: Bool = false
  @State private var isHovering: Bool = false
  @State private var selectedIndex: Int = 0
  @Binding var searchText: String
  @FocusState private var isFocused

  public init(
    title: String,
    placeholder: String = "Select",
    searchText: Binding<String>,
    selection: Selection,
    options: [(String, Content?)] = [],
    variant: WrappedInputField.Variant = .pill,
    clearAction: (() -> Void)? = nil
  ) {
    self.title = title
    self.placeholder = placeholder
    self._searchText = searchText
    self.selection = selection
    self.options = options
    self.variant = variant
    self.clearAction = clearAction
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      Text(title).pbFont(.caption)
        .padding(.bottom, Spacing.xxSmall)
      WrappedInputField(
        placeholder: placeholder,
        searchText: $searchText,
        selection: onSelection,
        variant: variant,
        isFocused: _isFocused,
        clearAction: { clearText },
        onItemTap: { removeSelected($0) },
        onViewTap: { showList.toggle() }
      )
      listView
    }
    .onAppear {
      showList = isFocused
      setKeyboardControls
    }
    .onChange(of: isFocused) {
      showList = $1
    }
  }
}

@available(iOS 17.0, *)
@available(macOS 14.0, *)
private extension PBTypeahead {
  @ViewBuilder
  var listView: some View {
    if showList {
      PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
        ScrollView {
          VStack(spacing: 0) {
            ForEach(Array(zip(searchResults.indices, searchResults)), id: \.0) { index, result in
              HStack {
                if let customView = result.1 {
                  customView
                } else {
                  Text(result.0)
                    .pbFont(.body)
                }
                Spacer()
              }
              .padding(.horizontal, Spacing.xSmall + 4)
              .padding(.vertical, Spacing.xSmall + 4)
              .frame(maxWidth: .infinity, alignment: .leading)
              .background(listBackgroundColor(index: index))
              .onHover {
                isHovering = $0
                selectedIndex = index
              }
              .onTapGesture {
                onListSelection(selected: index)
              }
            }
          }
        }
      }
    }
  }
  
  var optionsToShow: [String] {
    return selectedOptions.map { $0.0 }
  }
  
  var searchResults: [Option] {
    return searchText.isEmpty ? options : options.filter {
      $0.0.localizedCaseInsensitiveContains(searchText)
    }
  }
  
  func listBackgroundColor(index: Int?) -> Color {
    #if os(macOS)
    selectedIndex == index ? .hover : .card
    #elseif os(iOS)
    .card
    #endif
  }
  
  var onSelection: WrappedInputField.Selection {
    if selectedOptions.isEmpty {
      return selection.selectedOptions(options: [], placeholder: placeholder)
    } else {
      return selection.selectedOptions(options: optionsToShow, placeholder: placeholder)
    }
  }
  
  func onListSelection(selected index: Int) {
    selectedOptions = variantSelectedOptions(index)
    showList = false
    searchText = ""
  }
  
  func variantSelectedOptions(_ index: Int) -> [Option] {
    if options.count > 0 {
      selectedOptions.append(options.remove(at: index))
    }
    switch variant {
    case .text:
      guard let lastOption = selectedOptions.last else { return [] }
      options.append(contentsOf: selectedOptions.dropLast())
      selectedOptions = []
      selectedOptions.append(lastOption)
    default: break
    }
    return selectedOptions
  }

  var clearText: Void {
    if let action = clearAction {
      action()
    } else {
      searchText = ""
      options.append(contentsOf: selectedOptions)
      selectedOptions.removeAll()
      showList = false
    }
  }
  
  func removeSelected(_ index: Int) {
    if let selectedElementIndex = selectedOptions.indices.first(where: { $0 == index }) {
      let selectedElement = selectedOptions.remove(at: selectedElementIndex)
      options.append(selectedElement)
    }
  }
  
  var setKeyboardControls: Void {
    #if os(macOS)
    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
      if event.keyCode == 48  { // tab
        isFocused = true
      }
      if event.keyCode == 49 || event.keyCode == 36 { // space & return bar
        onListSelection(selected: selectedIndex)
        showList.toggle()
      }
      if event.keyCode == 51 { // delete
        if let lastElementIndex = selectedOptions.indices.last {
          let selectedElement = selectedOptions.remove(at: lastElementIndex)
          options.append(selectedElement)
        }
      }
      if event.keyCode == 125 { // arrow down
        selectedIndex = selectedIndex < searchResults.count ? (selectedIndex) + 1 : 0
      }
      else {
        if event.keyCode == 126 { // arrow up
          selectedIndex = selectedIndex > 1 ? (selectedIndex - 1) : 0
        }
      }
      return event
    }
  #endif
  }
}

@available(iOS 17.0, *)
@available(macOS 14.0, *)
public extension PBTypeahead {
  enum Selection {
    case single, multiple
    
    func selectedOptions(options: [String], placeholder: String) -> WrappedInputField.Selection {
      switch self {
      case .single: return .single(options.first)
      case .multiple: return .multiple(options)
      }
    }
  }
}

#Preview {
  registerFonts()
  if #available(iOS 17.0, *), #available(macOS 14.0, *) {
    return TypeaheadCatalog()
  } else {
    return EmptyView()
  }
}
