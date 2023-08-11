//
//  PBDoc.swift
//
//
//  Created by Carlos Lima on 11/08/23.
//

import SwiftUI

struct PBDoc<Content: View>: View {
  let title: String
  let content: Content

  public init(
    title: String,
    @ViewBuilder content: () -> Content
  ) {
    self.title = title
    self.content = content()
  }
  var body: some View {
    PBCard(border: false, borderRadius: BorderRadius.large, padding: Spacing.small, shadow: Shadow.deep) {
      VStack(alignment: .leading, spacing: Spacing.none) {
        Text(title).pbFont(.caption).padding(.bottom, Spacing.small)
        content
      }
    }
  }
}

struct PBDoc_Previews: PreviewProvider {
  static var previews: some View {
    PBDoc(title: "Example") {
      PBButton(
        title: "Button",
        action: {}
      )
    }
  }
}
