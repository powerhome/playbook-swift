//
//  PBTextInput.swift
//
//
//  Created by Everton Cunha on 04/03/22.
//

import SwiftUI

public struct PBTextInput: View {
  public let title: String?
  public let placeholder: String
  public let error: (Bool, String)?
  public let style: Style
  public let rightActionIcon: RightIcon?
  public var onChange: Bool?
#if os(iOS)
  public let keyboardType: UIKeyboardType
#endif
  @FocusState private var selected: Bool
  @State private var text: String = ""
  @State private var isHovering: Bool = false
  @State private var isIconHovering: Bool = false

  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.none) {
      if let title = title {
        Text(title)
          .pbFont(.caption)
          .padding(.bottom, Spacing.xSmall)
      }

      PBCard(padding: Spacing.none, style: borderStyle) {
        HStack(alignment: .center, spacing: Spacing.none) {
          leftView
          pbTextField
            .textFieldStyle(.plain)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .pbFont(.body(), color: .text(.default))
            .tint(.text(.default))
            .background(backgroundColor)
            .focused($selected, equals: true)
            .overlay {
              if let rightActionIcon = rightActionIcon {
                rightActionIndicator
                  .frame(maxWidth: .infinity, alignment: .trailing)
              }
            }
            .disabled(style == .disabled)

          rightView
        }

      }
      .overlay {
        RoundedRectangle(cornerRadius: BorderRadius.medium)
          .stroke(lineWidth: 1)
          .clipShape(
            Rectangle()
              .offset(x: offset, y: 0)
          )
          .foregroundColor(borderColor) 
      }
      .frame(height: 44)
      .onTapGesture {
        selected = true
      }
      .onHover { isHovering in
        self.isHovering = isHovering
      }

      if let error, error.0 {
        Text(error.1)
          .padding(.top, Spacing.xxSmall)
          .foregroundColor(.status(.error))
      }

      if onChange != nil {
        Text(text)
          .padding(.top, Spacing.xxSmall)
          .foregroundColor(.text(.default))
      }
    }
  }

  var divider: some View {
    Divider()
      .frame(width: 1)
      .overlay(borderColor)
  }
  
  var offset: CGFloat {
    switch style {
    case .leftIcon: return 44
    case .rightIcon: return -44
    default: return 0
    }
  }

  var rightActionIndicator: some View {
    Button {
      print("Some action here")
    } label: {
      rightActionIcon?.iconView
    }
    .padding(.horizontal, Spacing.small)
    .buttonStyle(.plain)
    .foregroundColor(rightActionIndicatorColor)
    .onHover { isHovering in
      isIconHovering = isHovering
    }
    .onTapGesture {
      isIconHovering = true
    }
  }

  @ViewBuilder
  var leftView: some View {
    if style == .leftIcon(true) {
      leftIcon
      divider
    }
    if style == .leftIcon(false) {
      leftIcon
    }
  }

  @ViewBuilder
  var rightView: some View {
    if style == .rightIcon(true) {
      divider
      rightIcon
    }
    if style == .rightIcon(false) {
      rightIcon
    }
  }

  var rightActionIndicatorColor: Color {
    let activeColor = isIconHovering ? Color.active : Color.text(.default)
    return selected ? activeColor : .clear
  }

  var rightIcon: some View {
    Button {
      print("some action here")
    } label: {
      PBIcon.fontAwesome(.userAstronaut, size: .x1)
    }
    .padding(.horizontal, Spacing.small)
    .buttonStyle(.plain)
    .foregroundColor(.border)
  }

  var leftIcon: some View {
    PBIcon.fontAwesome(.pen)
      .padding(.horizontal)
      .foregroundColor(.border)
  }

  var borderStyle: PBCardStyle {
    if error != nil {
      return .error
    } else {
      if style == .default {
        return selected ? .selected(type: .textInput) : .`default`
      } else {
        return .`default`
      }
    }
  }

  var borderColor: Color {
    if error != nil {
      return .status(.error)
    } else {
      return selected ? Color.pbPrimary : Color.border
    }
  }

  var placeHolder: Text {
    Text(placeholder)
      .foregroundColor(.text(.light))
      .font(
        Font.custom(
          ProximaNova.light.rawValue,
          size: TextSize.Body.base.rawValue
        )
      )
  }

  var backgroundColor: Color {
    switch style {
    case .disabled: return .border.opacity(0.3)
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
#if os(iOS)
  init(
    _ title: String? = nil,
    placeholder: String = "",
    error: (Bool, String)? = nil,
    style: Style = .default,
    keyboardType: UIKeyboardType = .default,
    rightActionIcon: RightIcon? = nil,
    onChange: Bool? = nil
  ) {
    self.title = title
    self.placeholder = placeholder
    self.error = error
    self.style = style
    self.keyboardType = keyboardType
    self.rightActionIcon = rightActionIcon
    self.onChange = onChange
  }
#elseif os(macOS)
  init(
    _ title: String? = nil,
    placeholder: String = "",
    error: (Bool, String)? = nil,
    style: Style = .default,
    rightActionIcon: RightIcon? = nil,
    onChange: Bool? = nil
  ) {
    self.title = title
    self.placeholder = placeholder
    self.error = error
    self.style = style
    self.rightActionIcon = rightActionIcon
    self.onChange = onChange
  }
#endif
}

public extension PBTextInput {
  enum Style: Equatable {
    case `default`
    case rightIcon(_ withDivider: Bool)
    case leftIcon(_ withDivider: Bool)
    case inline
    case disabled
  }
}

public enum RightIcon {
  case pbIcon(FontAwesome)
  case custom(AnyView)

  var iconView: AnyView {
    switch self {
    case .custom(let view): return view
    case .pbIcon(let icon): return AnyView(PBIcon.fontAwesome(icon, size: .x1))
    }
  }
}

public struct PBTextInput_Previews: PreviewProvider {
  public static var previews: some View {
    TextInputCatalog()
  }
}
