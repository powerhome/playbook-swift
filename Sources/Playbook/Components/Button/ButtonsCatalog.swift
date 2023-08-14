//
//  ButtonsCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

@available(macOS 13.0, *)
public struct ButtonsCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Simple") { PBButtonStyle_Previews.previews }

        PBDoc(title: "Full Width") {
          PBButton(
            fullWidth: true,
            title: "Full Width",
            action: {}
          )
        }

        PBDoc(title: "Button Icon Positions") {
          VStack(alignment: .leading, spacing: Spacing.small) {
            PBButton(
              title: "Button with Icon on Left",
              icon: PBIcon.fontAwesome(.user, size: .x1),
              action: {}
            )
            PBButton(
              title: "Button with Icon on Right",
              icon: PBIcon.fontAwesome(.user, size: .x1),
              iconPosition: .right,
              action: {}
            )
          }
        }

        PBDoc(title: "Circle Buttons") { PBCircleStyle_Previews.previews }

        PBDoc(title: "Button Sizes") {
          VStack(alignment: .leading, spacing: Spacing.small) {
            PBButton(
              size: .small,
              title: "Button sm",
              action: {}
            )
            PBButton(
              title: "Button md",
              action: {}
            )
            PBButton(
              size: .large,
              title: "Button lg",
              action: {}
            )
          }
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Button")
  }
}
