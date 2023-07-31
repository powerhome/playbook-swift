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
  public let error: Bool?
  public let style: Style
#if os(iOS)
  public let keyboardType: UIKeyboardType
#endif
  @FocusState private var selected: Bool
  @State private var text: String = ""
  @State private var isHovering: Bool = false

  public var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      if let title = title {
        Text(title)
          .pbFont(.caption)
      }
      PBCard(padding: Spacing.none, style: borderStyle) {
        HStack(alignment: .center, spacing: Spacing.none) {
          if style == .leftIcon(withDivider: true) {
            leftIcon
            Divider()
              .frame(width: 1)
              .overlay(borderColor)
          }

          if style == .leftIcon(withDivider: false) {
            leftIcon
          }

          pbTextField
            .textFieldStyle(.plain)
            .padding(.leading, 16)
            .frame(height: 44)
            .foregroundColor(.text(.default))
            .pbFont(.body())
            .focused($selected, equals: true)
            .tint(.text(.default))
            .background(backgroundColor)

            .border(width: 2, edges: borders, color: borderColor)

          if style == .rightIcon(withDivider: true) {
            Divider()
              .frame(width: 1)
              .overlay(borderColor)

            rightIcon
          }

          if style == .rightIcon(withDivider: false) {
            rightIcon
          }
        }

      }
      .frame(height: 44)
      .onTapGesture {
        selected = true
      }
      .onHover { isHovering in
        self.isHovering = isHovering
      }
    }
  }

  var borders: [Edge] {
    switch style {
    case .leftIcon: return [.top, .bottom, .trailing]
    case .rightIcon: return [.top, .bottom, .leading]
    default: return [.top, .bottom, .leading, .trailing]
    }
  }

  var roundedCorners: UIRectCorner {
    switch style {
    case .leftIcon: return [.bottomRight, .topRight]
    case .rightIcon: return [.bottomLeft, .topLeft]
    default: return [.allCorners]
    }
  }

  var rightIcon: some View {
    Button {

    } label: {
      PBIcon.fontAwesome(.pen)
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
    selected ? Color.pbPrimary : Color.border
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
    (selected || isHovering) ? .active : .card
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
    error: Bool? = nil,
    style: Style = .default,
    keyboardType: UIKeyboardType = .default
  ) {
    self.title = title
    self.placeholder = placeholder
    self.error = error
    self.style = style
    self.keyboardType = keyboardType
  }
#elseif os(macOS)
  init(
    _ title: String? = nil,
    placeholder: String = "",
    error: Bool? = nil,
    style: Style = .default
  ) {
    self.title = title
    self.placeholder = placeholder
    self.error = error
    self.style = style
  }
#endif
}

public extension PBTextInput {
  enum Style: Equatable {
    case `default`
    case rightIcon(withDivider: Bool)
    case leftIcon(withDivider: Bool)
    case inline
    case disabled
  }
}

public struct PBTextInput_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return List {
      Section("Default") {
        PBTextInput("First name", placeholder: "Enter first name")
        PBTextInput("", placeholder: "Enter zip code")
        PBTextInput("", style: .leftIcon(withDivider: true))
        PBTextInput("", style: .rightIcon(withDivider: true))
        PBTextInput("", style: .leftIcon(withDivider: false))
        PBTextInput("", style: .rightIcon(withDivider: false))
      }
    }
  }
}
