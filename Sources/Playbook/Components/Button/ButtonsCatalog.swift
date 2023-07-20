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
    List {
      Section("Button Variants") {
        PBButtonStyle_Previews.previews
      }

      Section("Button Icon Positions") {
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
      .listRowSeparator(.hidden)

      Section("Circle Buttons") {
        PBCircleStyle_Previews.previews
      }

      Section("Button Sizes") {
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
      .listRowSeparator(.hidden)
    }
    .navigationTitle("Buttons")
  }
}
