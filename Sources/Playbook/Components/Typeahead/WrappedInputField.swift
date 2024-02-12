//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  WrappedInputField.swift
//

import SwiftUI
import WrappingHStack

public struct WrappedInputField: View {
  private let placeholder: String
  private let selection: Selection
  private let clearAction: (() -> Void)?
  private let onItemTap: ((Int) -> Void)?
  private let onViewTap: (() -> Void)?
  private let shape = RoundedRectangle(cornerRadius: BorderRadius.medium)
  @Binding var searchText: String
  @State private var isHovering: Bool = false
  var isFocused: FocusState<Bool>.Binding

  init(
    placeholder: String = "Select",
    searchText: Binding<String>,
    selection: Selection,
    isFocused: FocusState<Bool>.Binding,
    clearAction: (() -> Void)? = nil,
    onItemTap: ((Int) -> Void)? = nil,
    onViewTap: (() -> Void)? = nil
  ) {
    self.placeholder = placeholder
    self._searchText = searchText
    self.selection = selection
    self.isFocused = isFocused
    self.clearAction = clearAction
    self.onItemTap = onItemTap
    self.onViewTap = onViewTap
  }
  
  public var body: some View {
    VStack(alignment: .leading) {
      HStack {
        WrappingHStack(indices, spacing: .constant(0)) { index in
          if indices.last == index {
            HStack(spacing: 0) {
              textfieldWithCustomPlaceholder
            }
          } else {
            gridView(index: index)
          }
        }
        .onTapGesture {
          isFocused.wrappedValue = true
        }
        .overlay {
          Color.white
            .opacity(isFocused.wrappedValue ? 0.001 : 0).onTapGesture {
              if isFocused.wrappedValue {
                onViewTap?()
              }
            }
        }
        
        dismissIconView
          .onTapGesture {
            clearAction?()
          }
          .padding(.trailing, Spacing.small)
      }
      .focused(isFocused)
      .background(backgroundColor)
      .overlay {
        shape.stroke(borderColor, lineWidth: 1.0)
      }
    }
    .onHover {
      isHovering = $0
      setupCursor
    }
  }
}

private extension WrappedInputField {
  var indices: Range<Int> {
    switch selection {
    case .multiple(_, let options): return  Range(0...options.count)
    case .single(_): return Range(0...1)
    }
  }
  
  @ViewBuilder
  var textfieldWithCustomPlaceholder: some View {
    ZStack(alignment: .leading) {
      if searchText.isEmpty {
        Text(placeholderText)
      }
      TextField("", text: $searchText)
        .textFieldStyle(.plain)
    }
    .pbFont(.body, color: textColor)
    .frame(maxWidth: .infinity)
    .frame(height: Spacing.xLarge)
    .padding(.leading, Spacing.small)
  }
  
  @ViewBuilder
  func gridView(index: Int) -> some View {
    switch selection {
    case .multiple(let variant, let options):
      let option = "\(options[index])"
      if options.count > 0 {
        variant.view(text: option)
          .onTapGesture { onItemTap?(index) }
          .padding(.leading, Spacing.xSmall)
          .padding(.vertical, Spacing.xSmall)
          .fixedSize()
      }
    case .single:
      EmptyView()
    }
  }
  
  var setupCursor: Void {
#if os(macOS)
    if isHovering {
      NSCursor.arrow.push()
    }
    else {
      NSCursor.arrow.pop()
    }
#endif
  }
  
  var placeholderText: String {
    switch selection {
    case .multiple(_, let elements): return elements.isEmpty ? placeholder : ""
    case .single(let element): return element ?? placeholder
    }
  }
  
  var textColor: Color {
    switch selection {
    case .multiple(_, _): return searchText.isEmpty ? .text(.light) : .text(.default)
    case .single(let element):
      return element == nil ? .text(.light) : .text(.default)
    }
  }
  
  var borderColor: Color {
    isFocused.wrappedValue ? .pbPrimary : .border
  }
  
  @ViewBuilder
  var dismissIconView: some View {
    switch selection {
    case .multiple(_, let elements):
      if !elements.isEmpty {
        dismissIcon
      }
    case .single(let element):
      if element != nil {
        dismissIcon
      }
    }
  }
  
  var dismissIcon: some View {
    PBIcon.fontAwesome(.times)
      .foregroundStyle(Color.text(.light))
  }
  
  var backgroundColor: Color {
    isHovering ? .background(.light) : .card
  }
}

public extension WrappedInputField {
  enum Selection {
    case single(String?), multiple(Selection.Variant, [String])
    
    public enum Variant {
      case text, pill, other(AnyView)
      
      @ViewBuilder
      func view(text: String) -> some View {
        switch self {
        case .text: Text(text).pbFont(.body)
        case .pill: TypeaheadPill(text)
        case .other(let view): view
        }
      }
    }
  }
}

#Preview {
  registerFonts()
  return WrappedInputFieldCatalog()
}

public struct WrappedInputFieldCatalog: View {
  @FocusState private var isFocused
  @State private var text: String = ""

  public var body: some View {
    VStack(spacing: Spacing.medium) {
      WrappedInputField(
        searchText: $text,
        selection: .single(nil),
        isFocused: $isFocused
      )

      WrappedInputField(
        searchText: $text,
        selection: .multiple(.pill, ["title1", "title2"]),
        isFocused: $isFocused
      )
      
      WrappedInputField(
        searchText: $text,
        selection: .multiple(.other(AnyView(PBPill("oi", variant: .primary))), ["title1", "title2"]),
        isFocused: $isFocused
      )
      
      WrappedInputField(
        searchText: $text,
        selection: .multiple(.other(AnyView(PBBadge(text: "title", variant: .primary))), ["title1", "title2"]),
        isFocused: $isFocused
      )
    }
    .padding()
  }
}
