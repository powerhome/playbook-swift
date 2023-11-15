//
//  ButtonsCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct ButtonsCatalog: View {
  let simpleButtons: some View = VStack(alignment: .leading, spacing: Spacing.small) {
    PBButton(
      title: "Button Primary",
      action: {}
    )
    PBButton(
      variant: .secondary,
      title: "Button Secondary",
      action: {})
    PBButton(
      variant: .link,
      title: "Button Link",
      action: {}
    )
    PBButton(
      variant: .disabled,
      title: "Button Disabled"
    )
  }
  .listRowSeparator(.hidden)
  .previewDisplayName("Button Variants")

  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Simple") { simpleButtons }

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
