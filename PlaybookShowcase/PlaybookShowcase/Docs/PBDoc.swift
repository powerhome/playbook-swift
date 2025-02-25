//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDoc.swift
//

import SwiftUI
import Playbook

struct PBDoc<Content: View>: View {
  let title: String
  let spacing: CGFloat
  let content: Content

  public init(
    title: String,
    spacing: CGFloat = Spacing.none,
    @ViewBuilder content: () -> Content
  ) {
    self.title = title
    self.spacing = spacing
    self.content = content()
  }
  var body: some View {
    PBCard(border: false, borderRadius: BorderRadius.large, padding: Spacing.small, shadow: Shadow.deep) {
      VStack(alignment: .leading, spacing: spacing) {
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
