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
    VStack(alignment: .leading, spacing: 0) {
      PBAvatar(image: Image("andrew", bundle: .module), size: .large)
        .position(top: 35, left: 0, bottom: 0, right: 0) {
          PBBadge(text: "On Roadtrip", rounded: true, variant: .neutral)
            .background(Color.card)
        }
    }
    .navigationTitle("Position")
  }
}

#Preview {
  registerFonts()
  return PositionCatalog()
}
