//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  AvatarCatalog.swift
//

import SwiftUI

public struct AvatarCatalog: View {
  public var body: some View {
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Default") {
            defaultAvatars
          }
          PBDoc(title: "Monogram") {
            monograms
          }
        }
        .padding(Spacing.medium)
      }
      .navigationTitle("Avatar")
  }

  var defaultAvatars: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBAvatar(image: Image("andrew", bundle: .module), size: .xxSmall, status: .online)
      PBAvatar(image: Image("andrew", bundle: .module), size: .xSmall, status: .away)
      PBAvatar(image: Image("andrew", bundle: .module), size: .small, status: .online)
      PBAvatar(image: Image("andrew", bundle: .module), size: .medium, status: .away)
      PBAvatar(image: Image("andrew", bundle: .module), size: .large, status: .online)
      PBAvatar(image: Image("andrew", bundle: .module), size: .xLarge, status: .offline)
    }
  }

  var monograms: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBAvatar(name: "Tim Wenhold", size: .xxSmall, status: .online)
      PBAvatar(name: "Tim Wenhold", size: .xSmall, status: .away)
      PBAvatar(name: "Tim Wenhold", size: .small, status: .online)
      PBAvatar(name: "Tim Wenhold", size: .medium, status: .away)
      PBAvatar(name: "Tim Wenhold", size: .large, status: .online)
      PBAvatar(name: "Tim", size: .xLarge, status: .offline)
    }
  }
}
