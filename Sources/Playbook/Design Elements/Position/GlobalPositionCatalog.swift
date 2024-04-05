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
  @State private var contentSize: CGSize = .zero
  public var body: some View {
    if #available(iOS 17.0, *) {
      ScrollView {
        if #available(iOS 17.0, *) {
          VStack(alignment: .leading, spacing: Spacing.medium) {
            PBDoc(title: "Default", spacing: Spacing.small) {
              avatarStatusView
            }
            PBDoc(title: "Image", spacing: Spacing.small) {
              imageBadgeView
            }
            PBDoc(title: "Card With Badge", spacing: Spacing.small) {
              cardWithBadgeView
            }
            PBDoc(title: "Nav", spacing: Spacing.small) {
              navView
            }
          }
          .scrollTargetLayout()
        } else {
          // Fallback on earlier versions
        }
        /*** Isis
         //        ForEach(Positiona.allCases, id: \.id) { pos in
         //
         //          Text(pos.rawValue).pbFont(.caption)
         //          HStack(spacing: Spacing.medium) {
         //
         
         
         //
         //            PBAvatar(image: Image("andrew", bundle: .module), size: .medium)
         //              .globalPosition(position: pos) {
         //                PBBadge(text: "5", rounded: true, variant: .chat)
         //              }
         //              .background(Color.pink)
         //
         //            PBAvatar(image: Image("andrew", bundle: .module), size: .small)
         //              .globalPosition(position: pos) {
         //                PBBadge(text: "5", rounded: true, variant: .chat)
         //              }
         //              .background(Color.pink)
         //
         //          }
         //          .padding()
         //          .background(Color.blue)
         //
         //        }
         
         //      }
         */
      }
      .scrollTargetBehavior(.viewAligned)
    } else {
      // Fallback on earlier versions
    }
  }
}


extension GlobalPositionCatalog {
  var avatarStatusView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBAvatar(
        image: Image("andrew", bundle: .module),
        size: .small
      )
      .globalPosition(overlay: {
        PBBadge(text: "On Roadtrip", rounded: true, variant: .chat)
      }, alignment: .bottom, top: 20, leading: -10, bottom: 0, trailing: 0)
      
      PBAvatar(
        image: Image("Anna", bundle: .module),
        size: .medium
      )
      .globalPosition(overlay: {
        PBBadge(
          text: "3",
          rounded: true,
          variant: .chat
        )
      }, alignment: .topLeading)
      PBAvatar(
        image: Image("Lu", bundle: .module),
        size: .large
      )
      .globalPosition(overlay: {
        PBBadge(text: "On Roadtrip",
                rounded: true,
                variant: .chat
        )
      }, alignment: Alignment.bottom, top: 0, leading: -20, bottom: 0, trailing: 0)
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
      .globalPosition(overlay: {
        PBBadge(
          text: "3",
          rounded: true,
          variant: .chat
        )
      }, alignment: .topTrailing, top: -10, leading: 0, bottom: 0, trailing: 0)
    }
  }
  
  var cardWithBadgeView: some View {
    VStack(spacing: Spacing.small) {
      PBCard{
        Text("A bunch of awesome content goes here. ")
      }
      .globalPosition(overlay: {
        PBBadge(
          text: "+1",
          rounded: true,
          variant: .info
        )
      }, alignment: .bottomLeading, top: 0, leading: -10, bottom: 0, trailing: 0)
      PBCard{
        Text("A bunch of awesome content goes here. ")
      }
      .globalPosition(overlay: {
        PBIconCircle(
          FontAwesome.rocket,
          size: .small,
          color: .orange.opacity(1.3)
        )
      }, alignment: .bottomLeading, top: 0, leading: -20, bottom: -5, trailing: 0)
    }
  }
  var navView: some View {
    PBNav(
      selected: $selected,
      variant: .normal,
      orientation: .horizontal
    ) {
      PBNavItem("First")
        .globalPosition(overlay: {
          PBBadge(
            text: "3",
            rounded: true,
            variant: .chat
          )
        }, alignment: .topTrailing, top: 0, leading: -25, bottom: 0, trailing: 0)
      PBNavItem("Second")
      PBNavItem("Third")
    }
  }
}

#Preview {
  registerFonts()
  return GlobalPositionCatalog()
}
