//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  WrappedInputField.swift
//

import SwiftUI

public struct GridInputField: View {
  private let placeholder: String
  private let selection: Selection
  private let clearAction: (() -> Void)?
  private let onItemTap: ((Int) -> Void)?
  private let onViewTap: (() -> Void)?
  private let shape = RoundedRectangle(cornerRadius: BorderRadius.medium)
  @Binding var searchText: String
  @State private var isHovering: Bool = false
  @State private var clearButtonIsHovering: Bool = false
  @State private var indicatorIsHovering: Bool = false
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
        HStack {
          PBGrid(alignment: .leading, horizontalSpacing: 0) {
            ForEach(indices, id: \.self) { index in
              if indices.last != index {
                gridView(index: index)
              }
            }
          }
          .layoutPriority(1)
          textfieldWithCustomPlaceholder
              .overlay {
                Color.white
                  .opacity(isFocused.wrappedValue ? 0.001 : 0)
                  .onTapGesture {
                    if isFocused.wrappedValue {
                      onViewTap?()
                    }
                  }
              }
          }
          .onTapGesture {
            isFocused.wrappedValue = true
            if isFocused.wrappedValue {
              onViewTap?()
            }
          }
        
        dismissIconView
          .onTapGesture {
            clearAction?()
          }
          .padding(.trailing, Spacing.xSmall)
        indicatorView
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
      setupCursor(hover: $0)
    }
  }
}

private extension GridInputField {
  var indices: Range<Int> {
    switch selection {
    case .multiple(_, let options): return Range(0...(options?.count ?? 0))
    case .single(_): return Range(0...1)
    }
  }
  
  @ViewBuilder
  var textfieldWithCustomPlaceholder: some View {
    ZStack(alignment: .leading) {
      if searchText.isEmpty {
        Text(placeholderText)
          .pbFont(.body, color: placeholderTextColor)
      }
      TextField("", text: $searchText)
        .onChange(of: searchText) { _ in
          if searchText.first == " " {
            searchText = searchText.replacingOccurrences(of: " ", with: "")
          }
        }
        .textFieldStyle(.plain)
        .pbFont(.body, color: textColor)
    }
    .frame(maxWidth: .infinity)
    .frame(height: Spacing.xLarge)
    .padding(.leading, Spacing.small)
  }
  
  @ViewBuilder
  func gridView(index: Int?) -> some View {
    switch selection {
    case .multiple(let variant, let options):
      if let index = index, let option = options?[index] {
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
  
  func setupCursor(hover: Bool) {
    #if os(macOS)
    if hover {
      NSCursor.arrow.push()
    }
    else {
      NSCursor.arrow.pop()
    }
    #endif
  }
  
  var placeholderText: String {
    switch selection {
    case .multiple(_, let elements): return elements?.isEmpty ?? true ? placeholder : ""
    case .single(let element): return element ?? placeholder
    }
  }

  var placeholderTextColor: Color {
    switch selection {
    case .multiple(_, _): return .text(.light)
    case .single(let element):
      return element == nil ? .text(.light) : .text(.default)
    }
  }
  
  var textColor: Color {
    return .text(.default)
  }
  
  var borderColor: Color {
    isFocused.wrappedValue ? .pbPrimary : .border
  }
  
  @ViewBuilder
  var dismissIconView: some View {
    switch selection {
    case .multiple(_, let elements):
      if !(elements?.isEmpty ?? true) {
        dismissIcon
      }
    case .single(let element):
      if element != nil {
        dismissIcon
      }
    }
  }
  
  var dismissIcon: some View {
    PBIcon(FontAwesome.times, size: .xSmall)
      .foregroundStyle(iconColor(on: clearButtonIsHovering))
      .onHover(disabled: false) {
        clearButtonIsHovering = $0
        isHovering = true
      }
  }
  
  var backgroundColor: Color {
    (isHovering || isFocused.wrappedValue) ? .background(.light) : .card
  }
  
  var indicatorView: some View {
    PBIcon(FontAwesome.chevronDown, size: .xSmall)
      .foregroundStyle(iconColor(on: indicatorIsHovering))
      .onHover(disabled: false) {
        indicatorIsHovering = $0
        isHovering = true
      }
      .onTapGesture {
        isFocused.wrappedValue = true
        onViewTap?()
      }
  }
  
  func iconColor(on hover: Bool) -> Color {
    if isFocused.wrappedValue, !hover {
      return Color.text(.light)
    } else if !isFocused.wrappedValue, hover {
      return Color.text(.light)
    } else if isFocused.wrappedValue, hover {
      return Color.text(.default)
    } else {
      return Color.text(.lighter)
    }
  }
}

public extension GridInputField {
  enum Selection {
    case single(String?), multiple(Selection.Variant, [String]?)
    
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
      GridInputField(
        searchText: $text,
        selection: .single(nil),
        isFocused: $isFocused
      )

      GridInputField(
        searchText: $text,
        selection: .multiple(.pill, ["title1", "title2"]),
        isFocused: $isFocused
      )
      
      GridInputField(
        searchText: $text,
        selection: .multiple(.other(AnyView(PBPill("oi", variant: .primary))), ["title1", "title2"]),
        isFocused: $isFocused
      )
      
      GridInputField(
        searchText: $text,
        selection: .multiple(.other(AnyView(PBBadge(text: "title", variant: .primary))), ["title1", "title2"]),
        isFocused: $isFocused
      )
    }
    .padding()
  }
}
