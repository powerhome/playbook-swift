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
  public let rightActionIcon: RightActionIcon?
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
//            .disabled(style == .disabled)
          rightView
        }
      }
      .overlay {
        RoundedRectangle(cornerRadius: BorderRadius.medium)
          .stroke(lineWidth: 1.2)
          .clipShape(
            Rectangle()
              .offset(x: offset, y: 0)
          )
          .foregroundColor(borderColor)
      }
      .frame(height: 45)
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
    switch style {
    case .leftIcon(let icon, divider: let withDivider):
      if withDivider {
        customIcon(icon.0, action: icon.1)
        divider
      } else {
        customIcon(icon.0, action: icon.1)
      }
    default: EmptyView()
    }
  }

  @ViewBuilder
  var rightView: some View {
    switch style {
    case .rightIcon(let icon, divider: let withDivider):
      if withDivider {
        divider
        customIcon(icon.0, action: icon.1)
      } else {
        customIcon(icon.0, action: icon.1)
      }
    default: EmptyView()
    }
  }

  var rightActionIndicatorColor: Color {
    let activeColor = isIconHovering ? Color.active : Color.text(.default)
    return selected ? activeColor : .clear
  }

  func customIcon(_ icon: FontAwesome, action: @escaping (() -> Void)) -> some View {
    Button {
      action()
    } label: {
      PBIcon.fontAwesome(icon, size: .medium)
    }
    .padding(.horizontal, 13)
    .buttonStyle(.plain)
    .foregroundColor(.border)
  }

  var borderStyle: PBCardStyle {
    if error != nil {
      return .error
    } else {
      switch style {
      case .default: return selected ? .selected(type: .textInput) : .`default`
      case .inline: return selected ? .selected(type: .textInput) : .inline
      default: return .`default`
      }
    }
  }

  var borderColor: Color {
    if error != nil {
      return .status(.error)
    } else {
      switch style {
      case .inline: return selected ? Color.pbPrimary : .clear
      default: return selected ? Color.pbPrimary : Color.border
      }
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
    rightActionIcon: RightActionIcon? = nil,
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
    rightActionIcon: RightActionIcon? = nil,
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
  enum Style {
    case `default`
    case rightIcon(_ actionIcon: (FontAwesome, (() -> Void)), divider: Bool)
    case leftIcon(_ actionIcon: (FontAwesome, (() -> Void)), divider: Bool)
    case inline
    case disabled
  }
}

public enum RightActionIcon {
  case pbIcon(FontAwesome, action: (() -> Void))
  case custom(AnyView, action: (() -> Void))

  var iconView: AnyView {
    switch self {
    case .custom(let view, _): return view
    case .pbIcon(let icon, _): return AnyView(PBIcon.fontAwesome(icon, size: .x1))
    }
  }
}

public struct PBTextInput_Previews: PreviewProvider {
  public static var previews: some View {
    TextInputCatalog()
  }
}
