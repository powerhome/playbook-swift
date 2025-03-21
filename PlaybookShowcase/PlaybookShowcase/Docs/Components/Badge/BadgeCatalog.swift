//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  BadgeCatalog.swift
//

import SwiftUI
import Playbook

public struct BadgeCatalog: View {
  public var body: some View {
    PBDocStack(title: "Badge") {
      PBDoc(title: "Rectangle") {
        rectangleView
      }

      PBDoc(title: "Rounded") {
        roundedView
      }

      PBDoc(title: "Chat Notification") {
        chatNotificationView
      }

      PBDoc(title: "Colors") {
        colorsView
      }
    }
  }
}

extension BadgeCatalog {
  var rectangleView: some View {
    HStack(spacing: Spacing.xSmall) {
      PBBadge(text: "+1", variant: .primary)
      PBBadge(text: "+4", variant: .primary)
      PBBadge(text: "+1000", variant: .primary)
    }
  }
  var roundedView: some View {
    HStack(spacing: Spacing.xSmall) {
      PBBadge(text: "+1", rounded: true, variant: .primary)
      PBBadge(text: "+4", rounded: true, variant: .primary)
      PBBadge(text: "+1000", rounded: true, variant: .primary)
    }
  }
  var chatNotificationView: some View {
    HStack(spacing: Spacing.xSmall) {
      PBBadge(text: "1", rounded: true, variant: .chat)
      PBBadge(text: "4", variant: .chat)
      PBBadge(text: "1000", variant: .chat)
    }
  }
  var colorsView: some View {
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

#Preview {
  registerFonts()
  return BadgeCatalog()
}
