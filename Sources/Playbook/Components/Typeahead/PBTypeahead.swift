//
//  PBTypeahead.swift
//
//
//  Created by Isis Silva on 15/08/23.
//

import SwiftUI

public struct PBTypeahead<Content: View>: View {
  let title: String
  let placeholder: String
  let variant: WrappedInputField.Variant
  let clearAction: (() -> Void)?
  let anyOptions: [(String, Content?)]
  @Binding var searchText: String
  @State private var options: [(String, Content?)] = []
  @State private var selectedOptions: [(String, Content?)] = []
  @State private var isFocused: Bool?
  @State private var isHovering: Bool = false
  @State private var hoveringItem: String = ""
  
  init(
    title: String,
    placeholder: String = "Select",
    searchText: Binding<String>,
    options: [(String, Content?)] = [],
    variant: WrappedInputField.Variant = .pill,
    clearAction: (() -> Void)? = nil
  ) {
    self.title = title
    self.placeholder = placeholder
    self._searchText = searchText
    self.anyOptions = options
    self.variant = variant
    self.clearAction = clearAction
  }
  
  public var body: some View {
    VStack(alignment: .leading) {
      Text(title).pbFont(.caption)
      WrappedInputField(
        title: title,
        placeholder: placeholder,
        searchText: $searchText,
        options: selectedOptions.map { $0.0 },
        variant: variant,
        isFocused: { isFocused = $0 },
        clearAction: { clearText },
        onItemTap: { removeSelected($0) }
      )
      
      listView
    }
    .onAppear {
      options = anyOptions
    }
    
  }
}

private extension PBTypeahead {
  func variantSelectedOptions(_ result: String) -> [(String, Content?)] {
    if let index = options.firstIndex(where: { $0.0 == result }){
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
  
  var searchResults: [(String, Content?)] {
    return (searchText.isEmpty && (isFocused ?? false)) ? options  : options.filter {
      $0.0.localizedCaseInsensitiveContains(searchText)
    }
  }
  
  var clearText: Void {
    if let action = clearAction {
      action()
    } else {
      searchText = ""
      options.append(contentsOf: selectedOptions)
      selectedOptions = []
    }
  }
  
  func removeSelected(_ element: String) {
    if let selectedElementIndex = selectedOptions.firstIndex(where: { $0.0 == element }) {
      let selectedElement = selectedOptions.remove(at: selectedElementIndex)
      options.append(selectedElement)
    }
  }
  
  @ViewBuilder
  var listView: some View {
    if let focused = isFocused, focused, !searchResults.isEmpty {
      PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
        ScrollView {
          VStack(spacing: 0) {
            ForEach(searchResults, id: \.0) { (result, value) in
              HStack {
                if let value = value {
                  value
                } else {
                  Text(result)
                }
                Spacer()
              }
              .padding(.horizontal, Spacing.xSmall + 4)
              .padding(.vertical, Spacing.xSmall)
              .background(listBackgroundColor(item: result))
              .onHover { _ in hoveringItem = result }
              .frame(maxWidth: .infinity, alignment: .leading)
              .onTapGesture {
                selectedOptions = variantSelectedOptions(result)
                isFocused = nil
                searchText = ""
              }
            }
          }
        }
      }
    }
  }

  private func listBackgroundColor(item: String) -> Color {
    hoveringItem == item ? .hover : .card
  }
}

struct PBTypeahead_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return TypeaheadCatalog()
  }
}
