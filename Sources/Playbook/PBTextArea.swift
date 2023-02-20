//
//  PBTextArea.swift
//  
//
//  Created by Everton Cunha on 04/03/22.
//

import SwiftUI

public struct PBTextArea: View {
  @Binding var text: String
  var title: String

  public init(_ title: String, text: Binding<String>) {
    self.title = title
    self._text = text
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(title)
        .pbFont(.title4, color: .light)
      PBCard(padding: 0) {
        TextEditor(text: $text)
          .padding(.top, 4)
          .padding(.horizontal, 12)
          .frame(height: 88)
          .pbForegroundColor(.text(.textDefault))
          .pbFont(.body())
      }
    }
  }
}

struct PBTextArea_Previews: PreviewProvider {
    static var previews: some View {
      PBTextArea("Title", text: .constant("Text"))
        .padding(16)
        .preferredColorScheme(.light)

      PBTextArea("Title", text: .constant("Text"))
        .padding(16)
        .preferredColorScheme(.dark)
    }
}
