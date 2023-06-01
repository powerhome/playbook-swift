//
//  TextAreaCatalog.swift
//
//
//  Created by Israel Molestina on 5/31/23.
//

import SwiftUI

public struct TextAreaCatalog: View {

  @State var text = ""
  @State var maxBlockerText = ""
  @State var customText = "Default value text"

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
      PBTextArea("Label", text: $text)
      PBTextArea("Label", text: $text, placeholder: "Placeholder with text")
      PBTextArea("Label", text: $customText)
    }
  }

  func errorView() -> some View {
    VStack(alignment: .leading) {
      PBTextArea("Label", text: $text, error: "this field has an error!")
    }
  }

  func characterCountView() -> some View {
    VStack(alignment: .leading) {
      PBTextArea("Count Only", text: $text, characterCount: true)
      PBTextArea("Max Characters", text: $text, characterCount: true, maxCharacterCount: 10)
      PBTextArea(
        "Max Characters W/ Blocker",
        text: $maxBlockerText,
        characterCount: true,
        maxCharacterCount: 20,
        maxCharacterBlock: true
      )
      PBTextArea("Max Characters W/ Error", text: $text, characterCount: true, maxCharacterCount: 75)
    }
  }

  func inlineView() -> some View {
    VStack(alignment: .leading) {
      PBTextArea("Label", text: $text)
    }
  }

}
