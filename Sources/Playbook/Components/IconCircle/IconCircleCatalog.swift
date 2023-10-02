//
//  IconCircleCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

@available(macOS 13.0, *)
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
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Icon Circle")
  }
}
