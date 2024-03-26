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
    .navigationTitle("Global Positioning")

  }
}

extension PositionCatalog {
  var avatarStatusView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBAvatar(image: Image("andrew", bundle: .module), size: .large)
        .position(top: 75, left: 40) {
          PBBadge(text: "On Roadtrip", rounded: true, variant: .neutral)
            .background(Color.card)
        }
      PBAvatar(image: Image("Anna", bundle: .module), size: .large)
        .position(top: 10, left: 10) {
          PBBadge(text: "5", rounded: true, variant: .chat)
        }
      PBAvatar(image: Image("Anna", bundle: .module), size: .large)
        .position(top: 75, left: 40) {
          PBBadge(text: "On Roadtrip", rounded: true, variant: .neutral)
            .background(Color.card)
        }
    }
  }
  var imageBadgeView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBImage(image: nil, placeholder: Image("Forest", bundle: .module), size: .xSmall, rounded: .sharp)
        .position(top: 25, left: 55, bottom: 25) {
          PBBadge(text: "3", rounded: true, variant: .chat)
        }
    }
  }
  var cardWithBadgeView: some View {
    VStack(spacing: Spacing.small) {
      PBCard{
        Text("A bunch of awesome content goes here. ")
      }
      .position(top: 90) {
        PBBadge(text: "+1", variant: .primary)
      }
      PBCard {
        Text("A bunch of awesome content goes here. ")
          
      }
      .position(top: 90) {
        PBIconCircle(FontAwesome.rocket, size: .small, color: .orange.opacity(1.3))
      }
    }.padding(.all, 10)
  }
  var navView: some View {
    PBNav(
      selected: $selected,
      variant: .normal,
      orientation: .horizontal
    ) {
      PBNavItem("First")
        .position(top: 12, left: 60) {
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
