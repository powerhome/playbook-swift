//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  OnlineStatusCatalog.swift
//

import SwiftUI
import Playbook

public struct OnlineStatusCatalog: View {
  public var body: some View {
    PBDocStack(title: "Online Status", spacing: Spacing.medium) {
      PBDoc(title: "Small") {
        smallStatusView
      }
      PBDoc(title: "Medium") {
        mediumStatusView
      }
      PBDoc(title: "Large") {
        largeStatusView
      }
      PBDoc(title: "Borderless") {
        borderlessStatusView
      }
    }
  }
}

extension OnlineStatusCatalog {
  var smallStatusView: some View {
    HStack(spacing: Spacing.xxSmall) {
      PBOnlineStatus(
        borderColor: .white
      )
      PBOnlineStatus(
        color: .status(.success),
        borderColor: .white
      )
      PBOnlineStatus(
        color: .status(.warning),
        borderColor: .white
      )
      PBOnlineStatus(
        color: .status(.error),
        borderColor: .white
      )
      PBOnlineStatus(
        color: .status(.info),
        borderColor: .white
      )
      PBOnlineStatus(
        color: .status(.primary),
        borderColor: .white
      )
    }
  }
  var mediumStatusView: some View {
    HStack(spacing: Spacing.xxSmall) {
      PBOnlineStatus(
        size: .medium,
        borderColor: .white
      )
      PBOnlineStatus(
        color: .status(.success),
        size: .medium,
        borderColor: .white
      )
      PBOnlineStatus(
        color: .status(.warning),
        size: .medium,
        borderColor: .white
      )
      PBOnlineStatus(
        color: .status(.error),
        size: .medium,
        borderColor: .white
      )
      PBOnlineStatus(
        color: .status(.info),
        size: .medium,
        borderColor: .white)
      PBOnlineStatus(
        color: .status(.primary),
        size: .medium,
        borderColor: .white
      )
    }
  }
  var largeStatusView: some View {
    HStack(spacing: Spacing.xxSmall) {
      PBOnlineStatus(
        size: .large,
        borderColor: .white
      )
      PBOnlineStatus(
        color: .status(.success),
        size: .large,
        borderColor: .white
      )
      PBOnlineStatus(
        color: .status(.warning),
        size: .large,
        borderColor: .white
      )
      PBOnlineStatus(
        color: .status(.error),
        size: .large,
        borderColor: .white
      )
      PBOnlineStatus(
        color: .status(.info),
        size: .large,
        borderColor: .white
      )
      PBOnlineStatus(
        color: .status(.primary),
        size: .large,
        borderColor: .white
      )
    }
  }
  var borderlessStatusView: some View {
    
    HStack(spacing: Spacing.xxSmall) {
      PBOnlineStatus( 
        size: .small,
        variant: .borderless
      )
      PBOnlineStatus(
        color: .status(.success),
        size: .small,
        variant: .borderless
      )
      PBOnlineStatus(
        color: .status(.warning),
        size: .small,
        variant: .borderless
      )
      PBOnlineStatus(
        color: .status(.error), 
        size: .small,
        variant: .borderless
      )
      PBOnlineStatus(
        color: .status(.info),
        size: .small,
        variant: .borderless
      )
      PBOnlineStatus(
        color: .status(.primary),  
        size: .small,
        variant: .borderless
      )
    }
  }
}
#Preview {
  registerFonts()
  return OnlineStatusCatalog()
}
