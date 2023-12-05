//
//  PBTypeahead.swift
//
//
//  Created by Isis Silva on 15/08/23.
//

import SwiftUI

public struct PBTypeahead: View {
  let title: String
  let placeholder: String
  let variant: WrappedInputField.Variant
  let clearAction: (() -> Void)?
  @Binding var searchText: String
  @State private var options: [String]
  @State private var selectedOptions: [String] = []
  @State private var isFocused: Bool?

  init(
    title: String,
    placeholder: String = "Select",
    searchText: Binding<String>,
    options: [String] = [],
    variant: WrappedInputField.Variant = .pill,
    clearAction: (() -> Void)? = nil
  ) {
    self.title = title
    self.placeholder = placeholder
    self._searchText = searchText
    self.options = options
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
        options: selectedOptions,
        variant: variant,
        isFocused: { isFocused = $0 },
        clearAction: { clearText },
        onItemTap: { removeSelected($0) }
      )
      .onTapGesture {
        isFocused?.toggle()
      }

      listView
    }
  }
}

private extension PBTypeahead {
  func variantSelectedOptions(_ result: String) -> [String] {
    if let index = options.firstIndex(of: result) {
      options.remove(at: index)
      selectedOptions.append(result)
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
  
  var searchResults: [String] {
    let stringCollection = options.map { "\($0)" }
    return (searchText.isEmpty && (isFocused ?? false)) ? stringCollection  : stringCollection.filter {
      $0.localizedCaseInsensitiveContains(searchText)
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
    if let selectedElementIndex = selectedOptions.firstIndex(where: { $0 == element }) {
      let selectedElement = selectedOptions.remove(at: selectedElementIndex)
      options.append(selectedElement)
    }
  }
  
  @ViewBuilder
  var listView: some View {
    if let focused = isFocused, focused, !searchResults.isEmpty {
      PBCard(alignment: .leading, padding: Spacing.small) {
        ScrollView {
          ForEach(searchResults, id: \.self) { result in
            HStack {
              Text(result)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture {
              selectedOptions = variantSelectedOptions(result)
              isFocused = false
            }
          }
        }
        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
      }
      .frame(maxWidth: .infinity)
      .pbShadow(.deeper)
    }
  }
}

struct PBTypeahead_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return TypeaheadCatalog()
  }
}
