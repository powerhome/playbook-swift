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
  @State var maxCharacterText = ""
  @State var maxBlockerText = ""
  @State var maxBlockerErrorText = ""
  @State var inlineText = ""

  public init() {}

  public var body: some View {
    List {
      Section("Default") {
        defaultView()
      }
      .listRowSeparator(.hidden)

      Section("TextArea W/ Error") {
        errorView()
      }

      Section("Character Counter") {
        characterCountView()
      }
      .listRowSeparator(.hidden)

      Section("Inline") {
        inlineView()
      }
    }
    .navigationTitle("Textarea")
  }

  func defaultView() -> some View {
    VStack(alignment: .leading) {
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

  func errorView() -> some View {
    VStack(alignment: .leading) {
      PBTextArea(
        "Label",
        text: $errorText,
        error: "this field has an error!"
      )
    }
  }

  func characterCountView() -> some View {
    VStack(alignment: .leading) {
      PBTextArea(
        "Count Only",
        text: $countText,
        characterCount: true
      )
      PBTextArea(
        "Max Characters",
        text: $maxCharacterText,
        characterCount: true,
        maxCharacterCount: 10
      )
      PBTextArea(
        "Max Characters W/ Blocker",
        text: $maxBlockerText,
        characterCount: true,
        maxCharacterCount: 20,
        maxCharacterBlock: true
      )
      PBTextArea(
        "Max Characters W/ Error",
        text: $maxBlockerErrorText,
        characterCount: true,
        maxCharacterCount: 75
      )
    }
  }

  func inlineView() -> some View {
    VStack(alignment: .leading) {
      PBTextArea(
        "Label",
        text: $inlineText
      )
    }
  }

}
