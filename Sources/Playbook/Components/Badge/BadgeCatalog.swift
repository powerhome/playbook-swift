//
//  BadgeCatalog.swift
//
//
//  Created by Israel Molestina on 5/18/23.
//

import SwiftUI

public struct BadgeCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Rectangle") {
          HStack(spacing: Spacing.xSmall) {
            PBBadge(text: "+1", variant: .primary)
            PBBadge(text: "+4", variant: .primary)
            PBBadge(text: "+1000", variant: .primary)
          }
        }

        PBDoc(title: "Rounded") {
          HStack(spacing: Spacing.xSmall) {
            PBBadge(text: "+1", rounded: true, variant: .primary)
            PBBadge(text: "+4", rounded: true, variant: .primary)
            PBBadge(text: "+1000", rounded: true, variant: .primary)
          }
        }

        PBDoc(title: "Chat Notification") {
          HStack(spacing: Spacing.xSmall) {
            PBBadge(text: "1", rounded: true, variant: .chat)
            PBBadge(text: "4", variant: .chat)
            PBBadge(text: "1000", variant: .chat)
          }
        }

        PBDoc(title: "Colors") {
          VStack(spacing: Spacing.xSmall) {
            ForEach(PBBadge.Variant.allCases, id: \.self) { variant in
              HStack(spacing: Spacing.xSmall) {
                PBBadge(text: "+1", rounded: true, variant: variant)
                PBBadge(text: "+4", variant: variant)
                PBBadge(text: "+1000", variant: variant)
              }
            }
          }
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Badge")
  }
}
