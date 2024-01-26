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

  public init(color: Color = .product(.product1, category: .highlight), @ViewBuilder content: () -> Content) {
    self.content = content()
    self.color = color
  }

  public var body: some View {
    content
      .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      .background(color)
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
