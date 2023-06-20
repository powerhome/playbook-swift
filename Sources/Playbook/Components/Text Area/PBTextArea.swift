//
//  PBTextArea.swift
//
//
//  Created by Everton Cunha on 04/03/22.
//

import SwiftUI

public struct PBTextArea: View {
  var title: String

  @Binding var text: String

  public init(_ title: String, text: Binding<String>) {
    self.title = title
    _text = text
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.xxSmall) {
      Text(title)
        .pbFont(.title4, color: .text(.light))
      PBCard(padding: 0) {
        TextEditor(text: $text)
          .padding(.top, 4)
          .padding(.horizontal, 12)
          .frame(height: 88)
          .foregroundColor(.text(.default))
          .pbFont(.body())
      }
    }
  }
}

public struct PBTextArea_Previews: PreviewProvider {
  public static var previews: some View {
    PBTextArea("Title", text: .constant("Text"))
      .padding(16)
      .preferredColorScheme(.light)

    PBTextArea("Title", text: .constant("Text"))
      .padding(16)
      .preferredColorScheme(.dark)
  }
}
