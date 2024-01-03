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
        Text("Default Shadow")
          .pbFont(.caption, variant: .light, color: .text(.light))
          .padding(.trailing, 250)
          .padding(.top, 30)

          defaultShadow
       
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
          .padding(.trailing, 270)
          .padding(.top, 10)
        
         fourOptions
        
        Text("3 options")
          .pbFont(.caption, variant: .light, color: .text(.light))
          .padding(.trailing, 270)
          .padding(.top, 10)
       
          threeOptions
      }
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Tab Bar")
  }
}

public extension TabBarCatalog {
  var defaultShadow: some View {
    return HStack {
      PBTabBar(
        selectedTab: $selectedTab,
        hasBorder: false,
        hasShadow: true,
        icon: [.home, .calendar, .bell, .search, .ellipsisH],
        iconName: ["Home", "Calendar", "Notfications", "Search", "More"]
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
        iconName: ["Home", "Calendar", "Notfications", "Search", "More"]
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
        iconName: ["Home", "Calendar", "Notfications", "Search", "More"]
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
        iconName: ["Home", "Calendar", "Notfications", "Search"]
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
        iconName: ["Home", "Notfications", "Search"]
      )
    }
  }
}

//#Preview {
//    TabBarCatalog()
//}
