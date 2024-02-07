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
  private let variant: Variant
  private let clearAction: (() -> Void)?
  private let onItemTap: ((Int) -> Void)?
  private let onViewTap: (() -> Void)?
  private let shape = RoundedRectangle(cornerRadius: BorderRadius.medium)
  @Binding var searchText: String
  @State private var isHovering: Bool = false
  @FocusState private var isFocused

  init(
    placeholder: String = "Select",
    searchText: Binding<String>,
    selection: Selection,
    variant: Variant = .pill,
    isFocused: FocusState<Bool>,
    clearAction: (() -> Void)? = nil,
    onItemTap: ((Int) -> Void)? = nil,
    onViewTap: (() -> Void)? = nil
  ) {
    self.placeholder = placeholder
    self._searchText = searchText
    self.selection = selection
    self.variant = variant
    self._isFocused = isFocused
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
          isFocused = true
        }
        .overlay {
          Color.white
            .opacity(isFocused ? 0.001 : 0).onTapGesture {
              if isFocused {
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
      .focused($isFocused)
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
    case .multiple(let options): return  Range(0...options.count)
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
    case .multiple(let options):
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
    case .multiple(let elements): return elements.isEmpty ? placeholder : ""
    case .single(let element): return element ?? placeholder
    }
  }
  
  var textColor: Color {
    switch selection {
    case .multiple(_): return searchText.isEmpty ? .text(.light) : .text(.default)
    case .single(let element):
      return element == nil ? .text(.light) : .text(.default)
    }
  }
  
  var borderColor: Color {
    isFocused ? .pbPrimary : .border
  }
  
  @ViewBuilder
  var dismissIconView: some View {
    switch selection {
    case .multiple(let elements):
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
    case single(String?), multiple([String])
  }
  
  enum Variant {
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
        isFocused: _isFocused
      )

      WrappedInputField(
        searchText: $text,
        selection: .multiple(["title1", "title2"]),
        isFocused: _isFocused
      )
      
      WrappedInputField(
        searchText: $text,
        selection: .multiple(["title1", "title2"]),
        variant: .other(AnyView(PBPill("oi", variant: .primary))),
        isFocused: _isFocused
      )
      
      WrappedInputField(
        searchText: $text,
        selection: .multiple(["title1", "title2"]),
        variant: .other(AnyView(PBBadge(text: "title", variant: .primary))),
        isFocused: _isFocused
      )
    }
    .padding()
  }
}
