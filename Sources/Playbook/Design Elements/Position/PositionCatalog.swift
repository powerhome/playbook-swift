//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PositionCatalog.swift
//

import SwiftUI

public struct PositionCatalog: View {
  public var body: some View {
    VStack(alignment: .leading) {
      PBAvatar(image: Image("andrew", bundle: .module), size: .large)
        .overlay {
          PBBadge(text: "On Roadtrip", rounded: true, variant: .neutral)
            .background(Color.card)
            .positioning(top: 35, left: 0, bottom: 0, right: 0)
        }
    }
    .navigationTitle("Position")
  }
}

#Preview {
  registerFonts()
  return PositionCatalog()
}
