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
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(title).pbFont(.caption)
      HStack {
        gridView
          .onPreferenceChange(SizePreferenceKey.self) {
            gridSize = $0
            print("size: \($0)")
          }
          .frame(width: CGFloat(gridFrame))
        TextField(placeholder, text: $searchText)
          .focused($isFocused)
          .pbFont(.body, color: .text(.light))
        PBIcon.fontAwesome(.times)
          .padding(.trailing, Spacing.xSmall)
          .onTapGesture {
            clearText
          }
      }
      .padding(Spacing.xSmall)
      .background(
        RoundedRectangle(cornerRadius: BorderRadius.medium)
          .stroke(borderColor, lineWidth: 1)
      )
    
  listView
    }
  }
}

extension PBTypeahead {
  var borderColor: Color {
    isFocused ? .pbPrimary : .border
  }
  
  var gridView: some View {
    let columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 60, maximum: 80), spacing: 0), count: 3)
    return LazyVGrid(columns: columns) {
      ForEach(selectedElements, id: \.self) { element in
        selectedElementView(element).getItemFrame()
          .fixedSize()
          .onTapGesture {
            if let index = selectedElements.firstIndex(of: element) {
              selectedElements.remove(at: index)
              suggestions.append(element)
            }
          }
        
      }
    }
  }
  
  @ViewBuilder
  func selectedElementView(_ element: String) -> some View {
    switch variant {
    case .pill:
      Pill(element)
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
    var width = gridSize
    for i in 0..<selectedElements.count {
      if i < 3 {
        width += gridSize + 4
      }
    }
    return CFloat(width)
  }
  
  @ViewBuilder
  var listView: some View {
    if isFocused && !searchResults.isEmpty {
      PBCard {
        ScrollView {
          ForEach(searchResults, id: \.self) { result in
            HStack {
              Text(result)
            }
            .frame(height: 40)
            .onTapGesture {
              selectedElements.append(result)
              if let index = suggestions.firstIndex(of: result) {
                suggestions.remove(at: index)
              }
              
            }
          }
        }
        .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
      }
      .frame(maxWidth: .infinity)
      .pbShadow(.deeper)
    }
  }
  
  enum Variant {
    case text, pill, other
    
    func view(text: String) -> AnyView {
      switch self {
      case .text: return AnyView(Text(text))
      case .pill: return AnyView(Pill(text).foregroundStyle(Color.teal))
      case .other: return AnyView(Text(text))
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

struct SizePreferenceKey: PreferenceKey {
  static let defaultValue: CGFloat = .zero
  
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = value >= nextValue() ? value : nextValue()
  }
}

extension View {
  func getItemFrame() -> some View {
    self.background(GeometryReader { geometry in
      self
        .preference(key: SizePreferenceKey.self, value: geometry.size.width)
        .onAppear {
          print("width: \(geometry.size.width)")
        }
    })
  }
}
