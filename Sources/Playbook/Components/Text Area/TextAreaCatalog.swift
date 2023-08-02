//
//  TextAreaCatalog.swift
//
//
//  Created by Israel Molestina on 5/31/23.
//

import SwiftUI

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
    List {
      Section("Default") {
        defaultView()
      }
      .listRowSeparator(.hidden)

      Section("Inline") {
        inlineView()
      }

      Section("TextArea W/ Error") {
        errorView()
      }

      Section("Character Counter") {
        characterCountView()
      }
      .listRowSeparator(.hidden)

    }
    .navigationTitle("Textarea")
  }

  func defaultView() -> some View {
    VStack(alignment: .leading) {
      PBTextArea(
        "Label",
        text: $defaultText
      )
      .padding(.bottom, Spacing.small)
      PBTextArea(
        "Label",
        text: $placeholderText,
        placeholder: "Placeholder with text"
      )
      .padding(.bottom, Spacing.small)
      PBTextArea(
        "Label",
        text: $customText
      )
    }
  }

  func errorView() -> some View {
    VStack(alignment: .leading) {
      PBTextArea(
        "Label",
        text: $errorText,
        error: "This field has an error!"
      )
    }
  }

  func characterCountView() -> some View {
    VStack(alignment: .leading) {
      PBTextArea(
        "Count Only",
        text: $countText,
        characterCount: .count
      )
      .padding(.bottom, Spacing.small)
      PBTextArea(
        "Max Characters",
        text: $maxCharacterText,
        characterCount: .maxCharacterCount(100)
      )
      .padding(.bottom, Spacing.small)
      PBTextArea(
        "Max Characters W/ Blocker",
        text: $maxBlockerText,
        characterCount: .maxCharacterCountBlock(100)
      )
      .padding(.bottom, Spacing.small)
      PBTextArea(
        "Max Characters W/ Error",
        text: $maxBlockerErrorText,
        characterCount: .maxCharacterCountError(90, "Too many characters!")
      )
    }
  }

  func inlineView() -> some View {
    VStack(alignment: .leading) {
      PBTextArea(
        "",
        text: $inlineText,
        inline: true
      )
    }
  }

}
