//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  AdaptiveStack.swift
//

import SwiftUI

struct AdaptiveStack<Content: View>: View {
  let isStacked: Bool
  let spacing: CGFloat?
  let content: () -> Content

  init(
    isStacked: Bool,
    spacing: CGFloat? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.isStacked = isStacked
    self.spacing = spacing
    self.content = content
  }

  var body: some View {
    Group {
      if isStacked {
        VStack(spacing: spacing, content: content)
      } else {
        HStack(spacing: spacing, content: content)
      }
    }
  }
}

struct AdaptiveStack_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      AdaptiveStack(isStacked: true) {
        Text("OI")
        Text("OI")
      }

      AdaptiveStack(isStacked: false) {
        Text("OI")
        Text("OI")
      }
    }
  }
}
