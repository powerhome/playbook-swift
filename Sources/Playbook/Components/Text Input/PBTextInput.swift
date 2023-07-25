//
//  PBTextInput.swift
//
//
//  Created by Everton Cunha on 04/03/22.
//

import SwiftUI

public extension PBTextInput {
#if os(iOS)
  public init(
    _ title: String? = nil,
    placeholder: String = "",
    error: Bool? = nil,
    keyboardType: UIKeyboardType = .default
  ) {
    self.title = title
    self.placeholder = placeholder
    self.error = error
    self.keyboardType = keyboardType
  }
#endif
}

public struct PBTextInput: View {
  public let title: String?
  public let placeholder: String
  public let error: Bool?
#if os(iOS)
  public let keyboardType: UIKeyboardType
#endif
  @FocusState private var selected: Bool
  @State private var text: String = ""
  @State private var isHovering: Bool = false

#if os(macOS)
  public init(
    _ title: String? = nil,
    placeholder: String = "",
    error: Bool? = nil
  ) {
    self.title = title
    self.placeholder = placeholder
    self.error = error
  }
#endif

  public var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      if let title = title {
        Text(title)
          .pbFont(.caption)
      }
      PBCard(padding: 0, style: style(selected)) {
        HStack(alignment: .center, spacing: Spacing.none) {
          PBIcon.fontAwesome(.pen)
            .padding(.horizontal)
            .foregroundColor(.border)

          Divider()
            .frame(width: 1)
            .overlay(selected ? Color.pbPrimary : Color.border)

          pbTextField
            .textFieldStyle(.plain)
            .padding(.leading, 16)
            .frame(height: 44)
            .foregroundColor(.text(.default))
            .pbFont(.body())
            .focused($selected, equals: true)
            .tint(.text(.default))

          Button {

          } label: {
            PBIcon.fontAwesome(.pen)
          }
          .padding(.trailing, Spacing.small)
        }
          .background(backgroundColor)
      }
      .onTapGesture {
        selected = true
      }
      .onHover { isHovering in
        self.isHovering = isHovering
      }
    }
  }

  func style(_ isSelected: Bool) -> PBCardStyle {
    if error != nil {
      return .error
    } else {
      return selected ? .selected(type: .textInput) : .`default`
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

public struct PBTextInput_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return List {
      Section("Default") {
        PBTextInput("First name", placeholder: "Enter first name")
        PBTextInput("", placeholder: "Enter zip code")
        PBTextInput("")
      }
    }
  }
}
