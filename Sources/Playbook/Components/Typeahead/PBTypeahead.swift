//
//  PBTypeahead.swift
//  
//
//  Created by Isis Silva on 15/08/23.
//

import SwiftUI

struct PBTypeahead: View {
  @State private var searchText = ""
  @State private var suggestions: [String]
  @State private var selectedElement: [String] = []
  @State private var typeaheadFrame: CGRect = .zero
  @FocusState private var isFocused
  @Binding var popoverValue: AnyView?
  var title: String
  var variant: Variant

  init(
    suggestions: [String] = ["Apple", "Banana", "Cherry", "Grapes", "Orange"],
    title: String,
    variant: Variant,
    popoverValue: Binding<AnyView?>
  ) {
    self.suggestions = suggestions
    self.title = title
    self.variant = variant
    self._popoverValue = popoverValue
  }

  var body: some View {
    VStack {
      PBTextInput(
        title,
        text: $searchText,
        style: .typeahead(leftView)
      )
      .onTapGesture {
      
          popoverValue = AnyView(
            PBPopover(parentFrame: $typeaheadFrame, dismissAction: { popoverValue = nil }) {
              ForEach(searchResults, id: \.self) { suggestion in
                Text(suggestion)
                  .pbFont(.body)
//                  .padding(.horizontal)
//                  .padding(.vertical, 8)
//                  .frame(maxWidth: .infinity, alignment: .leading)
                  .border(Color.border, width: 0.5)
                  .frame(maxWidth: typeaheadFrame.width - 28, alignment: .leading)
                  .onTapGesture {
                    selectedElement.append(suggestion)
                    if let index = suggestions.firstIndex(of: suggestion) {
                      suggestions.remove(at: index)
                    }
                    searchText = ""
                    isFocused = false
                  }
              }
              
            }
              
          )
        
      }
      .focused($isFocused, equals: true)
      .onChange(of: searchText) { _ in
        _ = searchResults
      }
      .frameGetter($typeaheadFrame)
    
    }.frame(maxWidth: .infinity, alignment: .leading)
  }
}

extension PBTypeahead {
  private var leftView: AnyView {
    if !selectedElement.isEmpty {
      return AnyView(
        LazyHGrid(rows: [GridItem(.adaptive(minimum: 54))], spacing: 0) {
          ForEach(selectedElement, id: \.self) { element in
            switch variant {
            case .pill:
              PBPill(element, variant: .primary)
                .padding(.horizontal, 4)
                .onTapGesture {
                  if let index = selectedElement.firstIndex(of: element) {
                    selectedElement.remove(at: index)
                    suggestions.append(element)
                  }
                }
            case .text:
              Text(element)
                .pbFont(.body)
                .padding(.horizontal, 4)
            case .other:
              Text(element)
                .pbFont(.body)
                .padding(.horizontal, 4)
            }
          }
        }
      )
    } else {
      return AnyView(EmptyView())
    }
  }

  var searchResults: [String] {
    return (searchText.isEmpty && isFocused) ? suggestions : suggestions.filter {
      $0.localizedCaseInsensitiveContains(searchText)
    }
  }

  enum Variant {
    case text, pill, other
  }
}

struct PBTypeahead_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return TypeaheadCatalog()
  }
}
