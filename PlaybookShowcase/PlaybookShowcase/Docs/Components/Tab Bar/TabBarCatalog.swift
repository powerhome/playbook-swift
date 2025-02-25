//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  TabBarCatalog.swift
//

import SwiftUI
import Playbook

public struct TabBarCatalog: View {
  @State var selectedTab: Int? = 0
  @State var selectedTab1: Int? = 0
  @State var selectedTab2: Int? = 0
  @State var selectedTab3: Int? = 0
  @State var selectedTab4: Int? = 0
  public var body: some View {
    PBDocStack(title: "Tab Bar", padding: Spacing.xxSmall) {
      TabBarDoc("Default", spacing: Spacing.small) {
        defaultShadow
      }

      TabBarDoc("Without Shadow", spacing: Spacing.small) {
        withoutShadow
      }
      
      TabBarDoc("With Border", spacing: Spacing.small) {
        withBorder
      }
      
      TabBarDoc("4 options", spacing: Spacing.small) {
        fourOptions
      }

      TabBarDoc("3 options", spacing: Spacing.small) {
        threeOptions
      }
    }
  }
}

public extension TabBarCatalog {
  var defaultShadow: some View {
    return HStack {
      PBTabBar(
        selectedTab: $selectedTab,
        border: false,
        shadow: true,
        icons: [
          TabIcon(icon: .home, name: "Home"),
          TabIcon(icon: .calendar, name: "Calendar"),
          TabIcon(icon: .bell, name: "Notfications"),
          TabIcon(icon: .search, name: "Search"),
          TabIcon(icon: .ellipsisH, name: "More")
        ]
       )
    }
  }
  var withoutShadow: some View {
    return HStack {
      PBTabBar(
        selectedTab: $selectedTab1,
        border: false,
        shadow: false,
        icons: [
          TabIcon(icon: .home, name: "Home"),
          TabIcon(icon: .calendar, name: "Calendar"),
          TabIcon(icon: .bell, name: "Notfications"),
          TabIcon(icon: .search, name: "Search"),
          TabIcon(icon: .ellipsisH, name: "More")
        ]
      )
    }
  }
  var withBorder: some View {
    return HStack {
      PBTabBar(
        selectedTab: $selectedTab2,
        border: true,
        shadow: false,
        icons: [
          TabIcon(icon: .home, name: "Home"),
          TabIcon(icon: .calendar, name: "Calendar"),
          TabIcon(icon: .bell, name: "Notfications"),
          TabIcon(icon: .search, name: "Search"),
          TabIcon(icon: .ellipsisH, name: "More")
        ]
      )
    }
  }
  var fourOptions: some View {
    return HStack(spacing: Spacing.large) {
      PBTabBar(
        selectedTab: $selectedTab3,
        border: false,
        shadow: true,
        icons: [
          TabIcon(icon: .home, name: "Home"),
          TabIcon(icon: .calendar, name: "Calendar"),
          TabIcon(icon: .bell, name: "Notfications"),
          TabIcon(icon: .search, name: "Search")
        ]
      )
    }
  }
  var threeOptions: some View {
    return HStack {
      PBTabBar(
        selectedTab: $selectedTab4,
        border: false,
        shadow: true,
        icons: [
          TabIcon(icon: .home, name: "Home"),
          TabIcon(icon: .calendar, name: "Calendar"),
          TabIcon(icon: .bell, name: "Notfications")
        ]
      )
    }
  }
}

fileprivate struct TabBarDoc<Content: View>: View {
  let title: String
  let spacing: CGFloat
  let content: Content
  
  init(
    _ title: String,
    spacing: CGFloat = 0,
    @ViewBuilder content: () -> Content
  ) {
    self.title = title
    self.spacing = spacing
    self.content = content()
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: spacing) {
      Text(title)
        .pbFont(.caption, variant: .light, color: .text(.light))
        .padding(.leading, Spacing.medium)
      content
    }
  }
}
