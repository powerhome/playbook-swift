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
  private let shape = RoundedRectangle(cornerRadius: BorderRadius.medium)
  @Binding var focus: Bool
  @Binding var searchText: String
  @State private var isHovering: Bool = false
  @FocusState private var isFocused
  @Binding var isPresented: Bool
  init(
    title: String,
    placeholder: String = "Select",
    searchText: Binding<String>,
    selection: Selection,
    variant: Variant = .pill,
    isFocused: Binding<Bool>,
    clearAction: (() -> Void)? = nil,
    onItemTap: ((String) -> Void)? = nil,
    isPresented: Binding<Bool>
  ) {
    self.title = title
    self.placeholder = placeholder
    self._searchText = searchText
    self.selection = selection
    self.variant = variant
    self._focus = isFocused
    self.clearAction = clearAction
    self.onItemTap = onItemTap
    _isPresented = isPresented
  }
  
  public var body: some View {
    VStack(alignment: .leading) {
      HStack {
        WrappingHStack(indices, spacing: .constant(0)) { index in
          if indices.last == index {
              textfieldWithCustomPlaceholder
          } else {
            gridView(index: index)
          }
        }
          
        dismissIconView
          .onTapGesture {
            clearAction?()
          }
          .padding(.trailing, Spacing.small)
      }
      .background(backgroundColor)
      .overlay {
        shape
          .stroke(borderColor, lineWidth: 1.0)
      }
    }
    .onHover { isHovering = $0
      #if os(macOS)
      if isHovering {
          NSCursor.arrow.push()
      }
      else {
          NSCursor.arrow.pop()
      }
      #endif
    }
    .onChange(of: focus) {
      isFocused = $0
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
    #if os(macOS)
    ZStack(alignment: .leading) {
      if searchText.isEmpty {
        Text(placeholderText)
      }
      TextField("", text: $searchText)
        .textFieldStyle(.plain)
        .focused($isFocused)
    }
    .pbFont(.body, color: textColor)
    .frame(maxWidth: .infinity)
    .frame(height: Spacing.xLarge)
    .padding(.leading, Spacing.small)
    .overlay(
      HStack {
        Color.white.opacity(isPresented ? 0 : 0.01)
        Spacer()
      } .contentShape(Rectangle())
    )
    .onTapGesture {
       isPresented.toggle()
      isFocused = true
    }
    #elseif os(iOS)
    ZStack(alignment: .leading) {
      if searchText.isEmpty {
        Text(placeholderText)
      }
      TextField("", text: $searchText)
        .textFieldStyle(.plain)
        .focused($isFocused)
        .frame( height: Spacing.xLarge)
        .frame(maxWidth: .infinity)
    }
    .pbFont(.body, color: textColor)
    .padding(.leading, Spacing.small)
    .frame(maxWidth: .infinity)
    .frame(height: Spacing.xLarge)
    #endif
  }
  
  @ViewBuilder
  func gridView(index: Int) -> some View {
    switch selection {
    case .multiple(let options):
      let option = "\(options[index])"
      if options.count > 0 {
        variant.view(text: option)
          .onTapGesture { onItemTap?(option) }
          .padding(.leading, Spacing.xSmall)
          .padding(.vertical, Spacing.xSmall)
          .fixedSize()
      }
    case .single:
      EmptyView()
    }
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
  return VStack(spacing: Spacing.medium) {
    WrappedInputField(
      title: "title",
      searchText: .constant(""),
      selection: .single(nil),
      isFocused: .constant(true), isPresented: .constant(true)
    )

    WrappedInputField(
      title: "title",
      searchText: .constant(""),
      selection: .multiple(["title1", "title2"]),
      isFocused: .constant(false), isPresented: .constant(true)
    )
    
    WrappedInputField(
      title: "title",
      searchText: .constant(""),
      selection: .multiple(["title1", "title2"]),
      variant: .other(AnyView(PBPill("oi", variant: .primary))),
      isFocused: .constant(false), isPresented: .constant(true)
    )
    
    WrappedInputField(
      title: "title",
      searchText: .constant(""),
      selection: .multiple(["title1", "title2"]),
      variant: .other(AnyView(PBBadge(text: "title", variant: .primary))),
      isFocused: .constant(false), isPresented: .constant(true)
    )
  }
  .padding()
}
