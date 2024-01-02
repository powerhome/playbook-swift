//
//  TabBarCatalog.swift
//
//
//  Created by Rachel Radford on 12/20/23.
//

import SwiftUI

public struct TabBarCatalog: View {
  @State var selectedTab: String = ""
  @State var selectedTab1: String = ""
  @State var selectedTab2: String = ""
  @State var selectedTab3: String = ""
  @State var selectedTab4: String = ""
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.small) {
        Text("Drop Shadow")
          .pbFont(.caption, variant: .light, color: .text(.light))
          .padding(.trailing, 250)
          .padding(.top, 30)

          dropShadow
       
        Text("Without Shadow")
          .pbFont(.caption, variant: .light, color: .text(.light))
          .padding(.trailing, 220)
          .padding(.top, 10)
       
          withoutShadow
        
        Text("With Border")
          .pbFont(.caption, variant: .light, color: .text(.light))
          .padding(.trailing, 250)
          .padding(.top, 10)
      
          withBorder
        
        Text("4 options")
          .pbFont(.caption, variant: .light, color: .text(.light))
          .padding(.trailing, 250)
          .padding(.top, 10)
        
         fourOptions
        
        Text("3 options")
          .pbFont(.caption, variant: .light, color: .text(.light))
          .padding(.trailing, 250)
          .padding(.top, 10)
       
          threeOptions
      }
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Tab Bar")
  }
}

public extension TabBarCatalog {
  var dropShadow: some View {
    return HStack {
      PBTabBar(
        selectedTab: $selectedTab,
        hasBorder: false,
        hasShadow: true,
        icon: [.home, .calendar, .bell, .search, .ellipsisH],
        iconName: ["home", "calendar", "notfications", "search", "more"]
      )
    }
  }
  var withoutShadow: some View {
    return HStack {
      PBTabBar(
        selectedTab: $selectedTab1,
        hasBorder: false,
        hasShadow: false,
        icon: [.home, .calendar, .bell, .search, .ellipsisH],
        iconName: ["home", "calendar", "notfications", "search", "more"]
      )
    }
  }
  var withBorder: some View {
    return HStack {
      PBTabBar(
        selectedTab: $selectedTab2,
        hasBorder: true,
        hasShadow: false,
        icon: [.home, .calendar, .bell, .search, .ellipsisH],
        iconName: ["home", "calendar", "notfications", "search", "more"]
      )
    }
  }
  var fourOptions: some View {
    return HStack(spacing: Spacing.large) {
      PBTabBar(
        selectedTab: $selectedTab3,
        hasBorder: false,
        hasShadow: true,
        icon: [.home, .calendar, .bell, .search],
        iconName: ["home", "calendar", "notfications", "search"]
      )
    }
  }
  var threeOptions: some View {
    return HStack {
      PBTabBar(
        selectedTab: $selectedTab4,
        hasBorder: false,
        hasShadow: true,
        icon: [.home, .bell, .search],
        iconName: ["home", "notfications", "search"]
      )
    }
  }
}

//#Preview {
//    TabBarCatalog()
//}
