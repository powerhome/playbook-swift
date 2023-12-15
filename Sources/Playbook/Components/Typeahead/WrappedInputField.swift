//
//  WrappedInputField.swift
//  
//
//  Created by Isis Silva on 05/12/23.
//

import SwiftUI
import WrappingHStack

public struct WrappedInputField: View {
  private let title: String
  private let placeholder: String
  private let selection: Selection
  private let variant: Variant
  private let clearAction: (() -> Void)?
  private let onItemTap: ((String) -> Void)?
  @Binding var focus: Bool
  private let shape = RoundedRectangle(cornerRadius: BorderRadius.medium)
  @Binding var searchText: String
  @State private var isHovering: Bool = false
  @FocusState private var isFocused

  init(
    title: String,
    placeholder: String = "Select",
    searchText: Binding<String>,
    selection: Selection,
    variant: Variant = .pill,
    isFocused: Binding<Bool>,
    clearAction: (() -> Void)? = nil,
    onItemTap: ((String) -> Void)? = nil
  ) {
    self.title = title
    self.placeholder = placeholder
    self._searchText = searchText
    self.selection = selection
    self.variant = variant
    self._focus = isFocused
    self.clearAction = clearAction
    self.onItemTap = onItemTap
  }

  public var body: some View {
    VStack(alignment: .leading) {
      HStack {
        WrappingHStack(indices, spacing: .constant(0)) { index in
          if indices.last == index {
            HStack(spacing: 0) {
              textfieldWithCustomPlaceholder
              Spacer()
             
            }
            .padding(.leading, Spacing.small)
          } else {
            itemView(index: index)
          }
        }
       
        PBIcon.fontAwesome(.times)
          .foregroundStyle(Color.text(.light))
          .onTapGesture {
            clearAction?()
          }
          .padding(.trailing, Spacing.small)
      }
      .background(backgroundColor)
      .clipShape(shape)
      .background(shape.stroke(borderColor, lineWidth: 1.2))
    }
    .onHover { isHovering = $0 }
    .onChange(of: focus) {
      isFocused = $0
    }
  }
}

extension WrappedInputField {
  var backgroundColor: Color {
    isHovering ? .background(.light) : .card
  }

  @ViewBuilder
  var textfieldWithCustomPlaceholder: some View {
    ZStack(alignment: .leading) {
      if searchText.isEmpty {
        Text(placeholderText)
          .pbFont(.body, color: textColor)
          .frame(minHeight: Spacing.xLarge)
      }
        TextField("", text: $searchText)
        .scrollDismissesKeyboard(.immediately)
          .textFieldStyle(.plain)
          .focused($isFocused)
          .pbFont(.body, color: .text(.default))
          .frame(minHeight: Spacing.xLarge)
      
    }
  }
  
  @ViewBuilder
  func itemView(index: Int) -> some View {
    switch selection {
    case .multiple(let options):
      if options.count > 0 {
        gridItem("\(options[index])")
          .padding(.leading, Spacing.xSmall)
          .padding(.vertical, Spacing.xSmall)
          .fixedSize()
      }
    case .single:
      EmptyView()
    }
  }
  
  private var placeholderText: String {
    switch selection {
    case .multiple(let elements): return elements.isEmpty ? placeholder : ""
    case .single(let element): return element ?? placeholder
    }
  }
  
  private var indices: Range<Int> {
    switch selection {
    case .multiple(let options): return  Range(0...options.count)
    case .single(_): return Range(0...1)
    }
  }

  private var borderColor: Color {
    isFocused ? .pbPrimary : .border
  }
  
  private var textColor: Color {
    switch selection {
    case .multiple(_): return searchText.isEmpty ? .text(.light) : .text(.default)
    case .single(let element):
      return element == placeholder ? .text(.light) : .text(.default)
      
    }
  }
  
  @ViewBuilder
  private func gridItem(_ item: String) -> some View {
    variant.view(text: item)
      .onTapGesture { onItemTap?(item) }
  }
  
  enum Variant {
    case text, pill, other(AnyView)
    
    @ViewBuilder
    func view(text: String) -> some View {
      switch self {
      case .text: Text(text)
      case .pill: Pill(text)
      case .other(let view): view
      }
    }
  }
  
  enum Selection {
    case single(String?), multiple([String])
  }
}

#Preview {
  registerFonts()
  return VStack {
    WrappedInputField(
      title: "title",
      searchText: .constant(""),
      selection: .single(nil),
      isFocused: .constant(true)
    )
    
    WrappedInputField(
      title: "title",
      searchText: .constant(""),
      selection: .multiple(["oi1", "oi2"]),
      isFocused: .constant(false)
    )
  }
}
