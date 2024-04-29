//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  IconCircleCatalog.swift
//

import SwiftUI

public struct IconCircleCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          PBIconCircle(FontAwesome.rocket)
        }

        PBDoc(title: "Size") {
          VStack(alignment: .leading, spacing: Spacing.small) {
            let pBIconSizes = [PBIcon.IconSize.small, PBIcon.IconSize.x1, PBIcon.IconSize.large]

            ForEach(pBIconSizes, id: \.self) { size in
              PBIconCircle(FontAwesome.rocket, size: size)
            }
          }
        }

        PBDoc(title: "Color") {
          VStack(spacing: Spacing.small) {
            ForEach(Color.DataColor.allCases, id: \.self) { color in
              PBIconCircle(FontAwesome.rocket, size: .small, color: Color.data(color))
            }
          }
        }
      }
      .padding(Spacing.medium)
    }
    .navigationTitle("Icon Circle")
  }
}
