//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTextInput.swift
//

import SwiftUI

public struct PBTextInput: View {
  public let title: String?
  public let placeholder: String
  public let error: (Bool, String)?
  public let style: Style
  public var onChange: Bool?
  #if os(iOS)
    public let keyboardType: UIKeyboardType
  #endif
  @Binding public var text: String
  @FocusState private var selected: Bool
  @State private var isHovering: Bool = false
  @State private var isIconHovering: Bool = false

  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.none) {
      if let title = title {
        Text(title)
          .pbFont(.caption)
          .padding(.bottom, Spacing.xSmall)
      }

      PBCard(padding: Spacing.none) {
        HStack(alignment: .center, spacing: Spacing.none) {
          leftView
          pbTextField
            .textFieldStyle(.plain)
            .padding(.horizontal, 16)
            .frame(maxHeight: .infinity)
            .pbFont(.body, color: .text(.default))
            .tint(.text(.default))
            .background(backgroundColor)
            .focused($selected, equals: true)
            .disabled(isDisabled)
          rightView
        }
      }
      .overlay(alignment: .center) {
        RoundedRectangle(cornerRadius: BorderRadius.medium)
          .stroke(lineWidth: lineWidth)
          .frame(maxHeight: .infinity)
          .clipShape(
            RoundedRectangle(cornerRadius: BorderRadius.medium)
          )
          .foregroundColor(borderColor)
      }
      .frame(height: 45)
      .onTapGesture {
        selected = true
      }
      .onHover(disabled: false) { isHovering in
        self.isHovering = isHovering
      }

      if let error, error.0 {
        Text(error.1)
          .pbFont(.body, color: .status(.error))
          .padding(.top, Spacing.xxSmall)
          .foregroundColor(.status(.error))
      }

      if onChange != nil {
        Text(text)
          .pbFont(.body)
          .padding(.top, Spacing.xxSmall)
          .foregroundColor(.text(.default))
      }
    }
  }

}

public extension PBTextInput {
  #if os(iOS)
    init(
      _ title: String? = nil,
      text: Binding<String>,
      placeholder: String = "",
      error: (Bool, String)? = nil,
      style: Style = .default,
      keyboardType: UIKeyboardType = .default,
      onChange: Bool? = nil
    ) {
      self.title = title
      self._text = text
      self.placeholder = placeholder
      self.error = error
      self.style = style
      self.keyboardType = keyboardType
      self.onChange = onChange
    }
  #elseif os(macOS)
    init(
      _ title: String? = nil,
      text: Binding<String>,
      placeholder: String = "",
      error: (Bool, String)? = nil,
      style: Style = .default,
      onChange: Bool? = nil
    ) {
      self.title = title
      self._text = text
      self.placeholder = placeholder
      self.error = error
      self.style = style
      self.onChange = onChange
    }
  #endif

  var isDisabled: Bool {
    switch style {
    case .disabled: return true
    default: return false
    }
  }

  var lineWidth: CGFloat {
    #if os(iOS)
      return 1.4
    #elseif os(macOS)
      return 2
    #endif
  }

  var divider: some View {
    Divider()
      .frame(width: 1)
      .overlay(borderColor)
      .opacity(dividerOpacity)
  }

  @ViewBuilder
  var leftView: some View {
    switch style {
    case .leftIcon(let icon, divider: _):
      customIcon(icon)
      divider
    case .typeahead(let view): view
    default: EmptyView()
    }
  }

  @ViewBuilder
  var rightView: some View {
    switch style {
    case .rightIcon(let icon, divider: _):
      divider
      customIcon(icon)
    default: EmptyView()
    }
  }

  func customIcon(_ icon: FontAwesome) -> some View {
    PBIcon.fontAwesome(icon, size: .x1)
      .foregroundColor(.text(.lighter))
      .frame(width: 45)
  }

  var borderStyle: PBCardStyle {
    if error != nil {
      return .error
    } else {
      switch style {
      case .default: return selected ? .selected(type: .textInput) : .`default`
      case .inline:
        if selected {
          return .selected(type: .textInput)
        } else if isHovering {
          return .`default`
        } else {
          return .inline
        }
      default: return .`default`
      }
    }
  }

  var borderColor: Color {
    if error != nil {
      return .status(.error)
    } else {
      switch style {
      case .inline:
        if selected {
          return Color.pbPrimary
        } else if isHovering {
          return .border
        } else {
          return .clear
        }
      case .disabled: return Color.border.opacity(0.5)
      default: return selected ? Color.pbPrimary : Color.border
      }
    }
  }

  var dividerOpacity: Double {
    switch style {
    case .leftIcon(_, divider: false): return 0
    case .rightIcon(_, divider: false): return 0
    default: return 1
    }
  }

  var placeHolder: Text {
    Text(placeholder)
      .foregroundColor(placeHolderColor)
      .font(
        Font.custom(
          ProximaNova.light.rawValue,
          size: TextSize.Body.base.rawValue
        )
      )
  }

  var placeHolderColor: Color {
    switch style {
    case .disabled: return .text(.light).opacity(0.5)
    default: return .text(.light)
    }
  }

  var backgroundColor: Color {
    switch style {
    case .disabled: return Color(hex: "#f4f4f6").opacity(0.5)
    default: return(selected || isHovering) ? .active : .card
    }
  }

  var pbTextField: some View {
    #if os(iOS)
      TextField("", text: $text, prompt: placeHolder)
        .keyboardType(keyboardType)
    #elseif os(macOS)
      MacOSTextField(text: $text, prompt: placeholder)
    #endif
  }
}

public extension PBTextInput {
  enum Style {
    case `default`
    case rightIcon(_ icon: FontAwesome, divider: Bool)
    case leftIcon(_ icon: FontAwesome, divider: Bool)
    case inline
    case disabled
    case typeahead(AnyView)
  }
}

public struct PBTextInput_Previews: PreviewProvider {
  public static var previews: some View {
    TextInputCatalog()
  }
}
