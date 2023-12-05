//
//  PBTypeahead.swift
//
//
//  Created by Isis Silva on 15/08/23.
//

import SwiftUI
import WrappingHStack

struct PBTypeahead: View {
  @State private var searchText = ""
  @State private var suggestions: [String]
  @State private var selectedElements: [String] = []
  @State private var isPresented: Bool = true
  @State private var gridSize: CGFloat = .zero
  @FocusState private var isFocused
  
  var title: String
  let placeholder: String = "Select"
  var variant: Variant = .pill
  
  init(
    suggestions: [String] = ["Apple", "Banana", "Cherry", "Grapes", "Orange"],
    title: String,
    variant: Variant = .pill
  ) {
    self.suggestions = suggestions
    self.title = title
    self.variant = variant
  }
  
  private var indices: Range<Int> {
    Range(0...selectedElements.count)
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(title).pbFont(.caption)
      WrappingHStack(indices) { element in
        if indices.last == element {
          HStack {
            TextField(placeholder, text: $searchText)
              .textFieldStyle(.plain)
              .focused($isFocused)
              .pbFont(.body, color: textColor)
              .frame(minHeight: Spacing.xLarge)
            
            PBIcon.fontAwesome(.times)
              .onTapGesture {
                clearText
              }
          }
          .padding(.horizontal, Spacing.small)
        } else {
          if selectedElements.count > 0 {
            gridItem(selectedElements[element])
              .padding(.leading, Spacing.xSmall)
              .padding(.vertical, Spacing.xSmall)
          }
        }
        
        
      }
      .background(
        RoundedRectangle(cornerRadius: BorderRadius.medium)
          .stroke(borderColor, lineWidth: 1)
      )
      
      listView
    }
  }
}

extension PBTypeahead {
  private var borderColor: Color {
    isFocused ? .pbPrimary : .border
  }
  
  private var textColor: Color {
    searchText.isEmpty ? .text(.light) : .text(.default)
  }
  
  @ViewBuilder
  func gridItem(_ item: String) -> some View {
    variant.view(text: item)
      .onTapGesture {
        if let index = selectedElements.firstIndex(of: item) {
          selectedElements.remove(at: index)
          suggestions.append(item)
        }
      }
  }
  
  var searchResults: [String] {
    return (searchText.isEmpty && isFocused) ? suggestions : suggestions.filter {
      $0.localizedCaseInsensitiveContains(searchText)
    }
  }
  
  var clearText: Void {
    searchText = ""
    suggestions.append(contentsOf: selectedElements)
    selectedElements = []
  }
  
  var gridFrame: CFloat {
    var width: CGFloat = 0
    for i in 0..<selectedElements.count {
      if i < 2 {
        width += gridSize + 4
      }
    }
    return CFloat(width)
  }
  
  @ViewBuilder
  var listView: some View {
    if isFocused && !searchResults.isEmpty {
      PBCard(alignment: .leading, padding: Spacing.small) {
        ScrollView {
          ForEach(searchResults, id: \.self) { result in
            HStack {
              Text(result)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onTapGesture {
              selectedElements.append(result)
              if let index = suggestions.firstIndex(of: result) {
                suggestions.remove(at: index)
              }
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
  
  enum Variant {
    case text, pill, other
    
    @ViewBuilder
    func view(text: String) -> some View {
      switch self {
      case .text: Text(text)
      case .pill: Pill(text)
      case .other: Text(text)
      }
    }
  }
}

struct PBTypeahead_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return TypeaheadCatalog()
  }
}
