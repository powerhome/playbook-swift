//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  TabBarCatalog.swift
//

import SwiftUI

public struct TabBarCatalog: View {
  @State var selectedTab: Int? = 0
  @State var selectedTab1: Int? = 0
  @State var selectedTab2: Int? = 0
  @State var selectedTab3: Int? = 0
  @State var selectedTab4: Int? = 0
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.small) {
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
    
      }.pbFont(.caption, variant: .light, color: .text(.light))
        .padding(.top, Spacing.medium)
    }
    .background(Color.background(.light))
    .navigationTitle("Tab Bar")
  }
}

public extension TabBarCatalog {
  static let icons: [TabIcon] = [
      .init(icon: .home, name: "Home"),
      .init(icon: .calendar, name: "Calendar"),
      .init(icon: .bell, name: "Notfications"),
      .init(icon: .search, name: "Search"),
      .init(icon: .ellipsisH, name: "More"),
    ]
  var defaultShadow: some View {
    return HStack {
      PBTabBar(
        selectedTab: $selectedTab,
        border: false,
        shadow: true,
        icons: TabBarCatalog.icons
       )
    }
  }
  var withoutShadow: some View {
    return HStack {
      PBTabBar(
        selectedTab: $selectedTab1,
        border: false,
        shadow: false,
        icons: TabBarCatalog.icons

      )
    }
  }
  var withBorder: some View {
    return HStack {
      PBTabBar(
        selectedTab: $selectedTab2,
        border: true,
        shadow: false,
        icons: TabBarCatalog.icons
        
      )
    }
  }
  var fourOptions: some View {
    return HStack(spacing: Spacing.large) {
      PBTabBar(
        selectedTab: $selectedTab3,
        border: false,
        shadow: true,
        icons: TabBarCatalog.icons.prefix(5).dropLast()
      )
    }
  }
  var threeOptions: some View {
    return HStack {
      PBTabBar(
        selectedTab: $selectedTab4,
        border: false,
        shadow: true,
        icons: TabBarCatalog.icons.prefix(4).dropLast()
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
 
//#Preview {
//    TabBarCatalog()
//}
