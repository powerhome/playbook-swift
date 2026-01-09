//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBCardHeader.swift
//

import SwiftUI

public struct PBCardHeader<Content: View>: View {
  let content: Content
  let color: Color
  let borderRadius: CGFloat

  public init(color: Color = .product(.product1, category: .highlight), borderRadius: CGFloat = BorderRadius.medium, @ViewBuilder content: () -> Content) {
    self.content = content()
    self.color = color
    self.borderRadius = borderRadius
  }

  public var body: some View {
    content
      .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      .background(
        UnevenRoundedRectangle(
          topLeadingRadius: borderRadius,
          bottomLeadingRadius: 0,
          bottomTrailingRadius: 0,
          topTrailingRadius: borderRadius
        )
        .fill(color)
      )
  }
}

// MARK: Preview

struct PBCardHeader_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return PBCardHeader {
      Text("Header").pbFont(.caption)
    }
  }
}
