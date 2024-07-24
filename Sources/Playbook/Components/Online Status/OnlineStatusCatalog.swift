//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  OnlineStatusCatalog.swift
//

import SwiftUI

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
        hasBorder: true
      )
      PBOnlineStatus(
        backgroundColor: .status(.success),
        hasBorder: true
      )
      PBOnlineStatus(
        backgroundColor: .status(.warning),
        hasBorder: true
      )
      PBOnlineStatus(
        backgroundColor: .status(.error),
        hasBorder: true
      )
      PBOnlineStatus(
        backgroundColor: .status(.info),
        hasBorder: true
      )
      PBOnlineStatus(
        backgroundColor: .status(.primary),
        hasBorder: true
      )
    }
  }
  var mediumStatusView: some View {
    HStack(spacing: Spacing.xxSmall) {
      PBOnlineStatus(
        size: .medium,
        hasBorder: true
      )
      PBOnlineStatus(
        backgroundColor: .status(.success),
        size: .medium,
        hasBorder: true
      )
      PBOnlineStatus(
        backgroundColor: .status(.warning),
        size: .medium,
        hasBorder: true
      )
      PBOnlineStatus(
        backgroundColor: .status(.error),
        size: .medium,
        hasBorder: true
      )
      PBOnlineStatus(
        backgroundColor: .status(.info),
        size: .medium,
        hasBorder: true)
      PBOnlineStatus(
        backgroundColor: .status(.primary),
        size: .medium,
        hasBorder: true
      )
    }
  }
  var largeStatusView: some View {
    HStack(spacing: Spacing.xxSmall) {
      PBOnlineStatus(
        size: .large,
        hasBorder: true
      )
      PBOnlineStatus(
        backgroundColor: .status(.success),
        size: .large,
        hasBorder: true
      )
      PBOnlineStatus(
        backgroundColor: .status(.warning),
        size: .large,
        hasBorder: true
      )
      PBOnlineStatus(
        backgroundColor: .status(.error),
        size: .large,
        hasBorder: true
      )
      PBOnlineStatus(
        backgroundColor: .status(.info),
        size: .large,
        hasBorder: true
      )
      PBOnlineStatus(
        backgroundColor: .status(.primary),
        size: .large,
        hasBorder: true
      )
    }
  }
  var borderlessStatusView: some View {
    
    HStack(spacing: Spacing.xSmall) {
      PBOnlineStatus( 
        size: .small,
        hasBorder: false
      )
      PBOnlineStatus(
        backgroundColor: .status(.success),
        size: .small,
        hasBorder: false
      )
      PBOnlineStatus(
        backgroundColor: .status(.warning),
        size: .small,
        hasBorder: false
      )
      PBOnlineStatus(
        backgroundColor: .status(.error), 
        size: .small,
        hasBorder: false
      )
      PBOnlineStatus(
        backgroundColor: .status(.info),
        size: .small,
        hasBorder: false
      )
      PBOnlineStatus(
        backgroundColor: .status(.primary),  
        size: .small,
        hasBorder: false
      )
    }
  }
}
#Preview {
  registerFonts()
  return OnlineStatusCatalog()
}
