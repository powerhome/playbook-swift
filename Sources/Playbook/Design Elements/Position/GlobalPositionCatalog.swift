//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PositionCatalog.swift
//

import SwiftUI

public struct GlobalPositionCatalog: View {
  @State private var selected: Int = 1
  
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Image", spacing: Spacing.small) {
          imageBadgeView
        }
        PBDoc(title: "Card With Icon Circle", spacing: Spacing.small) {
          cardWithBadgeView
        }
        PBDoc(title: "Nav", spacing: Spacing.small) {
          navView
        }
        PBDoc(title: "Avatar With Badge", spacing: Spacing.small) {
          avatarBadgeView
        }
        PBDoc(title: "Avatar With Card And Badge", spacing: Spacing.small) {
          avatarCardBadgeView
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Global Position")
  }
}

extension GlobalPositionCatalog {
  var navView: some View {
    PBNav(
      selected: $selected,
      variant: .normal,
      orientation: .horizontal
    ) {
      PBNavItem("First")
        .globalPosition(
          alignment: .topTrailing,
          top: Spacing.xSmall - 1,
          leading: 0,
          bottom: 0,
          trailing: Spacing.xSmall + 1
        ) {
          PBBadge(
            text: "3",
            rounded: true,
            variant: .chat
          )
        }
      PBNavItem("Second")
      PBNavItem("Third")
    }
  }

  var imageBadgeView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBImage(
        image: nil,
        placeholder: Image("Forest", bundle: .module),
        size: .xSmall,
        rounded: .sharp
      )
      .globalPosition(
        alignment: .topTrailing,
        top: -Spacing.xSmall,
        trailing: -Spacing.xSmall + 2
      ) {
        PBBadge(
          text: "3",
          rounded: true,
          variant: .chat
        )
      }
    }
  }
  
  var cardWithBadgeView: some View {
    VStack(spacing: Spacing.small) {
      PBCard{
        Text("A bunch of awesome content goes here. ")
      }
      .globalPosition(
        alignment: .bottomLeading,
        isCard: true
      ) {
        PBBadge(
          text: "+1",
          rounded: false,
          variant: .primary
        )
        .background(Color.white)
      }
      
      PBCard{
        Text("A bunch of awesome content goes here. ")
      }
      .globalPosition(
        alignment: .bottomLeading,
        isCard: true
      ) {
        PBIconCircle(
          FontAwesome.rocket,
          size: .small,
          color: .data(.data5)
        )
        .background(Color.white)
      }
    }
    .padding(Spacing.xSmall)
  }
  
  var avatarBadgeView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBAvatar(
        image: Image("Anna", bundle: .module),
        size: .large
      )
      .globalPosition(
        alignment: .topLeading,
        top: Spacing.xxSmall,
        leading: Spacing.xxSmall
      ) {
        PBBadge(
          text: "5",
          rounded: true,
          variant: .chat
        )
      }
    }
  }
  var avatarCardBadgeView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBAvatar(
        image: Image("andrew", bundle: .module),
        size: .large
      )
      .globalPosition(
        alignment: .bottom
      ) {
        PBBadge(text: "On Roadtrip", rounded: true, variant: .neutral)
      }
    }
  }
}

#Preview {
  registerFonts()
  return GlobalPositionCatalog()
}
