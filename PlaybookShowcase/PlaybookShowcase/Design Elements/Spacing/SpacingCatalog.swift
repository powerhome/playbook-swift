//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  SpacingCatalog.swift
//

import SwiftUI
import Playbook

public struct SpacingCatalog: View {
  public var body: some View {
    VStack(alignment: .leading) {
      List(Spacing.allCase, id: \.self.0) { space in
        Section("\(space.1) - \(Int(space.0)) px") {
          ZStack(alignment: .leading) {
            Rectangle()
              .fill(Color.background(.default))
            Rectangle()
              .fill(Color.product(.product1, category: .highlight))
              .frame(width: space.0)
          }
          .frame(height: Spacing.large)
          .border(Color.border, width: 1)
        }
        .padding()
        .listRowBackground(Color.card)
      }
    }
    .navigationTitle("Spacing")
  }
}

struct SpacingCatalog_Previews: PreviewProvider {
  static var previews: some View {
    SpacingCatalog()
  }
}
