//
//  ButtonsCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct ButtonsCatalog: View {
  @State private var count: Int = 153
  @State private var count1: Int = 5
  
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

        PBDoc(title: "Reaction Button") {
          HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
            PBReactionButton(count: $count, icon: "\u{1F389}", variant: .emoji)
            PBReactionButton(count: $count1, icon: "1️⃣", variant: .emoji)
            PBReactionButton(variant: .emoji)
            PBReactionButton(pbIcon: PBIcon(FontAwesome.user), variant: .defaultIcon)
          }
        }

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

