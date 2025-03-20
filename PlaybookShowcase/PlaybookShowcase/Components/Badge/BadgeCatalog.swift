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
      PBBadge(text: "+1", style: .rectangle, variant: .primary)
      PBBadge(text: "+4", style: .rectangle, variant: .primary)
      PBBadge(text: "+1000", style: .rectangle, variant: .primary)

    }
  }
  var roundedView: some View {
    HStack(spacing: Spacing.xSmall) {
      PBBadge(text: "+1", style: .rounded, variant: .primary)
      PBBadge(text: "+4", style: .rounded, variant: .primary)
      PBBadge(text: "+1000", style: .rounded, variant: .primary)
    }
  }
  var chatNotificationView: some View {
    HStack(spacing: Spacing.xSmall) {
      PBBadge(text: "1", style: .notification, variant: .chat)
      PBBadge(text: "4", style: .rounded, variant: .chat)
      PBBadge(text: "1000", style: .rounded, variant: .chat)
    }
  }

  var colorsView: some View {
    VStack(spacing: Spacing.xSmall) {
      ForEach(PBBadge.Variant.standardVariants, id: \.self) { variant in
        HStack(spacing: Spacing.xSmall) {
          PBBadge(text: "+1", style: .rounded, variant: variant)
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
