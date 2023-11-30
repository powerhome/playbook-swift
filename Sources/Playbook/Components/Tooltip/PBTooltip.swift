//
//  PBTooltip.swift
//
//
//  Created by Stephen Marshall on 11/29/23.
//

import SwiftUI

public struct PBTooltip: View {
  let delay: Int
  let icon: FontAwesome?
  let interaction: Bool
  let placement: Placement
  let text: String
  
  public init(delay: Int = 0, icon: FontAwesome? = nil, interaction: Bool = true, placement: Placement = .top, text: String) {
    self.delay = delay
    self.icon = icon
    self.interaction = interaction
    self.placement = placement
    self.text = text
  }
  
  public var body: some View {
    HStack {
      Text(text)
    }
  }
}

public extension PBTooltip {
  enum Placement {
    case top
    case bottom
    case leading
    case trailing
  }
}

public struct PBTooltip_Preview: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return PBTooltip(text: "PBTooltip")
  }
}
