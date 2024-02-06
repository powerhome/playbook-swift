//
//  PBTypeahead.swift
//
//
//  Created by Isis Silva on 15/08/23.
//

import SwiftUI

public struct PBTypeahead<Content: View>: View {
  private let title: String
  private let placeholder: String
  private let variant: WrappedInputField.Variant
  private let clearAction: (() -> Void)?
  private let selection: Selection
  @Binding var searchText: String
  @State private var options: [(String, Content?)] = []
  @State private var selectedOptions: [(String, Content?)] = []
  @State private var showList: Bool = false
  @FocusState private var isFocused
  @State private var isHovering: Bool = false
  @State private var selectedIndex: Int?

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
        onItemTap: { removeSelected($0) }
      )
      .overlay {
        Color.white
          .padding(.trailing, 60)
          .opacity(isFocused ? 0.001 : 0).onTapGesture {
          if isFocused {
            showList.toggle()
          }
        }
      }
      listView
    }
    .onAppear {
      showList = isFocused
    }
    .onChange(of: isFocused) {
      showList = $1
    }
  }
}

private extension PBTypeahead {
  @ViewBuilder
  var listView: some View {
    if showList {
      PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
        ScrollView {
          ForEach(Array(zip(searchResults.indices, searchResults)), id: \.0) { index, result in
            HStack {
              if let customView = result.1 {
                customView
              } else {
                Text(result.0)
                  .pbFont(.body)
                  .padding(.vertical, 4)
              }
              Spacer()
            }
            .padding(.horizontal, Spacing.xSmall + 4)
            .padding(.vertical, Spacing.xSmall)
            .onHover {
              isHovering = $0
              selectedIndex = index
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture {
              onListSelection(selected: index)
            }
            .background(listBackgroundColor(index: index))
          }
        }
      }
      .onAppear{
        setKeyboardControls
      }
    }
  }
  
  var optionsToShow: [String] {
    return selectedOptions.map { $0.0 }
  }
  
  var searchResults: [(String, Content?)] {
    return searchText.isEmpty ? options : options.filter {
      $0.0.localizedCaseInsensitiveContains(searchText)
    }
  }
  
  func listBackgroundColor(index: Int) -> Color {
    selectedIndex == index ? .hover : .card
  }
  
  var onSelection: WrappedInputField.Selection {
    if selectedOptions.isEmpty {
      return selection.selectedOptions(options: [], placeholder: placeholder)
    } else {
      return selection.selectedOptions(options: optionsToShow, placeholder: placeholder)
    }
  }
  
  func onListSelection(selected index: Int?) {
    selectedOptions = variantSelectedOptions(index)
    showList = false
    searchText = ""
  }
  
  func variantSelectedOptions(_ index: Int?) -> [(String, Content?)] {
    if let index = index, options.count > 0 {
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
}

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

public extension PBTypeahead {
  var setKeyboardControls: Void {
    #if os(macOS)
    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
      if event.keyCode == 48  { // tab
        isFocused = true
      }
      if event.keyCode == 49 || event.keyCode == 36 { // space bar
        if let index = selectedIndex {
          onListSelection(selected: index)
        }
        showList.toggle()
      }
      if event.keyCode == 51 { // delete
        if let lastElementIndex = selectedOptions.indices.last {
          let selectedElement = selectedOptions.remove(at: lastElementIndex)
          options.append(selectedElement)
        }
      }
      if event.keyCode == 125 { // arrow down
        selectedIndex = selectedIndex ?? 0 < searchResults.count ? (selectedIndex ?? 0) + 1 : 0
      }
      else {
        if event.keyCode == 126 { // arrow up
          selectedIndex = selectedIndex ?? 0 > 1 ? (selectedIndex ?? 0) - 1 : 0
        }
      }
      return event
    }
  #endif
  }
}


#Preview {
  registerFonts()
  if #available(iOS 16.0, *) {
    return TypeaheadCatalog()
  } else {
    return EmptyView()
  }
}
