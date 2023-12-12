//
//  WrappedInputField.swift
//  
//
//  Created by Isis Silva on 05/12/23.
//

import SwiftUI
import WrappingHStack

public struct WrappedInputField: View {
  let title: String
  let placeholder: Text?
  let options: [Any]
  let variant: Variant
  let clearAction: (() -> Void)?
  let onItemTap: ((String) -> Void)?
  @Binding var isFocused: Bool
  @Binding var searchText: String
  @FocusState private var focus

  init(
    title: String,
    placeholder: Text? = nil,
    searchText: Binding<String>,
    options: [Any] = [],
    variant: Variant = .pill,
    isFocused: Binding<Bool>,
    clearAction: (() -> Void)? = nil,
    onItemTap: ((String) -> Void)? = nil
  ) {
    self.title = title
    self.placeholder = placeholder
    self._searchText = searchText
    self.options = options
    self.variant = variant
    self._isFocused = isFocused
    self.clearAction = clearAction
    self.onItemTap = onItemTap
  }

  public var body: some View {
    VStack(alignment: .leading) {
      WrappingHStack(indices) { index in
        if indices.last == index {
          HStack {
            TextField("", text: $searchText, prompt: placeholder)
              .textFieldStyle(.plain)
              .focused($focus)
              .pbFont(.body, color: textColor)
              .frame(minHeight: Spacing.xLarge)
            PBIcon.fontAwesome(.times)
              .onTapGesture {
                clearAction?()
              }
          }
          .padding(.horizontal, Spacing.small)
        } else {
          if options.count > 0 {
            gridItem("\(options[index])")
              .padding(.leading, Spacing.xSmall)
              .padding(.vertical, Spacing.xSmall)
              .fixedSize()
          }
        }
      }
      .background(
        RoundedRectangle(cornerRadius: BorderRadius.medium)
          .stroke(borderColor, lineWidth: 1)
      )
    }
    .onChange(of: focus) { isFocused = $0 }
  }
}

extension WrappedInputField {
  private var indices: Range<Int> {
    Range(0...options.count)
  }

  private var borderColor: Color {
    focus ? .pbPrimary : .border
  }
  
  private var textColor: Color {
    searchText.isEmpty ? .text(.light) : .text(.default)
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
  
  @ViewBuilder
  func gridItem(_ item: String) -> some View {
    variant.view(text: item)
      .onTapGesture { onItemTap?(item) }
  }
}

#Preview {
  WrappedInputField(title: "title", searchText: .constant("some text"), options: ["option 1"], isFocused: .constant(true))
}
