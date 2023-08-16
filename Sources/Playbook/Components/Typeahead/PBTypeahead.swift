//
//  PBTypeahead.swift
//  
//
//  Created by Isis Silva on 15/08/23.
//

import SwiftUI

struct PBTypeahead: View {
  @State private var searchText = ""
  @State private var suggestions: [String] = ["Apple", "Banana", "Cherry", "Grapes", "Orange"]
  @State private var selectedElement: [String] = []
  @State private var isFocused: Bool = false
  
  var body: some View {
    VStack {
      PBTextInput(
        text: $searchText,
        style: .typeahead(
          leftView
        )
      )
      
      PBCard {
        ForEach(searchResults, id: \.self) { suggestion in
          Text(suggestion)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture {
              selectedElement.append(suggestion)
              if let index = suggestions.firstIndex(of: suggestion) {
                suggestions.remove(at: index)
              }
              searchText = ""
              
            }
//            .background(selectedElement.contains(suggestion) ? Color.red : Color.blue)
        }
      }
    }
    .frame(maxHeight: .infinity)
    .padding()
  }
  
  
  private var leftView: AnyView {
    if !selectedElement.isEmpty {
      return AnyView(
        LazyHGrid(rows: [GridItem(.flexible())]) {
        ForEach(selectedElement, id: \.self) { element in
          PBPill(element, variant: .primary)
            .padding()
            .onTapGesture {
              if let index = selectedElement.firstIndex(of: element) {
                selectedElement.remove(at: index)
                suggestions.append(element)
              }
            }
        }
        .searchable(text: $searchText)
      }
        )
    } else {
      return AnyView(EmptyView())
    }
  }
  
  var searchResults: [String] {
        if searchText.isEmpty {
            return suggestions
        } else {
            return suggestions.filter { $0.contains(searchText) }
        }
    }
  
  private func updateSuggestions() {
    suggestions = searchText.isEmpty ? [] : ["Apple", "Banana", "Cherry", "Grapes", "Orange"].filter {
      $0.localizedCaseInsensitiveContains(searchText)
    }
  }
  
  func style(_ isTextFocused: Bool) -> PBCardStyle {
    return isTextFocused ? .selected() : .default
  }
}

struct PBTypeahead_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return PBTypeahead()
  }
}
