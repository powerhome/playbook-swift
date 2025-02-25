//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  TextAreaCatalog.swift
//

import SwiftUI
import Playbook

public struct TextAreaCatalog: View {
  @State var defaultText = ""
  @State var placeholderText = ""
  @State var customText = "Default value text"
  @State var errorText = ""
  @State var countText = ""
  @State var maxCharacterText = "Counting characters!"
  @State var maxBlockerText = """
  This counter prevents the user from exceeding the maximum number of allowed characters.
  Just try it!
  """
  @State var maxBlockerErrorText = """
  This counter alerts the user that they have exceeded the maximum number of allowed characters.
  """
  @State var inlineText = "Try clicking into this text."

  public init() {}

  public var body: some View {
    PBDocStack(title: "Textarea") {
      PBDoc(title: "Default") {
        defaultView()
      }

      PBDoc(title: "Inline") {
        inlineView
      }

      PBDoc(title: "TextArea W/ Error") {
        textAreaErrorView
      }

      PBDoc(title: "Character Counter") {
        characterCountView()
      }
    }
  }
}

extension TextAreaCatalog {
  func defaultView() -> some View {
      VStack(alignment: .leading, spacing: Spacing.small) {
        PBTextArea(
          "Label",
          text: $defaultText
        )

        PBTextArea(
          "Label",
          text: $placeholderText,
          placeholder: "Placeholder with text"
        )

        PBTextArea(
          "Label",
          text: $customText
        )
      }
    }
  var inlineView: some View {
    PBTextArea(
      "",
      text: $inlineText,
      inline: true
    )
  }
  var textAreaErrorView: some View {
    PBTextArea(
      "Label",
      text: $errorText,
      error: "This field has an error!"
    )
  }
  func characterCountView() -> some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBTextArea(
        "Count Only",
        text: $countText,
        characterCount: .count
      )

      PBTextArea(
        "Max Characters",
        text: $maxCharacterText,
        characterCount: .maxCharacterCount(100)
      )

      PBTextArea(
        "Max Characters W/ Blocker",
        text: $maxBlockerText,
        characterCount: .maxCharacterCountBlock(100)
      )

      PBTextArea(
        "Max Characters W/ Error",
        text: $maxBlockerErrorText,
        characterCount: .maxCharacterCountError(90, "Too many characters!")
      )
    }
  }
}
