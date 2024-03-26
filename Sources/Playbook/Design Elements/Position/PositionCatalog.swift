//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PositionCatalog.swift
//

import SwiftUI

public struct PositionCatalog: View {
  @State private var selected: Int = 1
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Avatar") {
          avatarStatusView
        }
        PBDoc(title: "Image") {
          imageBadgeView
        }
        PBDoc(title: "Card With Badge") {
          cardWithBadgeView
        }
        PBDoc(title: "NavItem With Badge") {
          navView
        }
      }
      .padding(Spacing.large)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Global Position")

  }
}

extension PositionCatalog {
  var avatarStatusView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBAvatar(image: Image("andrew", bundle: .module), size: .large)
        .position(top: 35, left: 0, bottom: 0, right: 0) {
          PBBadge(text: "On Roadtrip", rounded: true, variant: .neutral)
            .background(Color.card)
        }
      PBAvatar(image: Image("Anna", bundle: .module), size: .large)
        .position(top: 0, left: 0, bottom: 30, right: 30) {
          PBBadge(text: "5", rounded: true, variant: .chat)
        }
      PBAvatar(image: Image("Anna", bundle: .module), size: .large)
        .position(top: 35, left: 0, bottom: 0, right: 0) {
          PBBadge(text: "On Roadtrip", rounded: true, variant: .neutral)
            .background(Color.card)
        }
    }
  }
  var imageBadgeView: some View {
    PBImage(image: nil, placeholder: Image("Forest", bundle: .module), size: .xSmall, rounded: .sharp)
      .position(top: 0, left: 30, bottom: 25, right: 0) {
        PBBadge(text: "3", rounded: true, variant: .chat)
    }
  }
  var cardWithBadgeView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBCard(alignment: .center, backgroundColor: .card, border: true, borderRadius: 0, style: .default, width: 350) {
        Text("A bunch of awesome content goes here. Yeah! It sure does! Okay!")
      }.position(top: 55, left: 0, bottom: 0, right: 145) {
        PBBadge(text: "+1", variant: .primary)
      }
      PBCard(alignment: .center, backgroundColor: .card, border: true, borderRadius: 0, style: .default, width: 350) {
        Text("A bunch of awesome content goes here. Yeah! It sure does! Okay!")
      }.position(top: 55, left: 0, bottom: 0, right: 145) {
        PBIconCircle(FontAwesome.rocket, size: .small, color: .orange.opacity(1.2))
      }
      Spacer(minLength: 0)
    }
  }
  var navView: some View {
    PBNav(
      selected: $selected,
      variant: .normal,
      orientation: .horizontal
    ) {
      PBNavItem("First")
        .position(top: 0, left: 20, bottom: 10, right: 0) {
          PBBadge(text: "3", rounded: true, variant: .chat)
        }
      PBNavItem("Second")
      PBNavItem("Third")
    }
  }
}
#Preview {
  registerFonts()
  return PositionCatalog()
}
