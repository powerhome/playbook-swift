//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBHighlight.swift
//

import SwiftUI

public struct PBHighlight: View {
  let text: String
  let highlightedText: [String]
  public init(
    text: String = "",
    highlightedText: [String] = [""]
  ) {
    self.text = text
    self.highlightedText = highlightedText
  }
   public var body: some View {
     Text(emphasizedText)
       .pbFont(.body, variant: .light, color: .text(.default))
    }
}

extension PBHighlight {
  var emphasizedText: AttributedString {
    return highlightedAttributedText(text: text, highlightedText: highlightedText)
  }
}
#Preview {
  registerFonts()
  return HighlightCatalog()
}
