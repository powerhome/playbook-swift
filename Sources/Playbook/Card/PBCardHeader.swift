//
//  PBCardHeader.swift
//  
//
//  Created by Alexandre Hauber on 27/07/21.
//

import SwiftUI

public struct PBCardHeader<Content: View>: View {
  let content: Content
  let color: PBColor

  public init(color: PBColor = .product(.windows), @ViewBuilder content: () -> Content) {
    self.content = content()
    self.color = color
  }

  public var body: some View {
    content
      .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      .background(color.color)
  }
}

struct PBCardHeader_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return PBCardHeader {
      Text("Header").pbFont(.caption)
    }
  }
}
