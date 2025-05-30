//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  AvatarCatalog.swift
//

import SwiftUI
import Playbook

public struct AvatarCatalog: View {
  public var body: some View {
    PBDocStack(title: "Avatar") {
      PBDoc(title: "Default") {
        defaultAvatars
      }
      PBDoc(title: "Monogram") {
        monograms
      }
      PBDoc(title: "Status Size") {
        statusSize
      }
      PBDoc(title: "Status color") {
        statusColor
      }
      PBDoc(title: "Greyscale") {
        greyScale
      }
    }
  }
}

extension AvatarCatalog {
  var defaultAvatars: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBAvatar(image: Image("andrew"), size: .xxSmall, status: .online)
      PBAvatar(image: Image("andrew"), size: .xSmall, status: .away)
      PBAvatar(image: Image("andrew"), size: .small, status: .online)
      PBAvatar(image: Image("andrew"), size: .medium, status: .away)
      PBAvatar(image: Image("andrew"), size: .large, status: .online)
      PBAvatar(image: Image("andrew"), size: .xLarge, status: .offline)
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

  var statusSize: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      VStack(spacing: Spacing.xxSmall) {
        PBAvatar(image: Image("andrew"), size: .small, status: .online)
        Text("Small").pbFont(.caption)
      }
      VStack(spacing: Spacing.xxSmall) {
        PBAvatar(image: Image("andrew"), size: .medium, status: .away)
        Text("Medium").pbFont(.caption)
      }
      VStack(spacing: Spacing.xxSmall) {
        PBAvatar(image: Image("andrew"), size: .large, status: .offline)
        Text("Large").pbFont(.caption)
      }
    }
  }

  var statusColor: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      VStack(spacing: Spacing.xxSmall) {
        PBAvatar(image: Image("andrew"), size: .medium, status: .online)
        Text("Online").pbFont(.caption)
      }
      VStack(spacing: Spacing.xxSmall) {
        PBAvatar(image: Image("andrew"), size: .medium, status: .away)
        Text("Away").pbFont(.caption)
      }
      VStack(spacing: Spacing.xxSmall) {
        PBAvatar(image: Image("andrew"), size: .medium, status: .offline)
        Text("Offline").pbFont(.caption)
      }
    }
  }

  var greyScale: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBAvatar(image: Image("andrew"), size: .xxSmall, status: .offline, isActive: false)
      PBAvatar(image: Image("andrew"), size: .xSmall, status: .offline, isActive: false)
      PBAvatar(image: Image("andrew"), size: .small, status: .offline, isActive: false)
      PBAvatar(image: Image("andrew"), size: .medium, status: .offline, isActive: false)
      PBAvatar(image: Image("andrew"), size: .large, status: .offline, isActive: false)
      PBAvatar(image: Image("andrew"), size: .xLarge, status: .offline, isActive: false)
    }
  }
}

#Preview {
  AvatarCatalog()
}
