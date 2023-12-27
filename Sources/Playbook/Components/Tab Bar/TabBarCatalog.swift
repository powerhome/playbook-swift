//
//  TabBarCatalog.swift
//
//
//  Created by Rachel Radford on 12/20/23.
//

import SwiftUI

public struct TabBarCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        Text("Drop Shadow")
          .pbFont(.caption, variant: .light, color: .text(.light))
          .padding(.trailing, 250)
          .padding(.top, 30)
        PBCard(alignment: .center, backgroundColor: Color.card, border: true, style: PBCardStyle.default, shadow: .deep) {
          dropShadow
        }
        Text("Without Shadow")
          .pbFont(.caption, variant: .light, color: .text(.light))
          .padding(.trailing, 220)
          .padding(.top, 10)
        PBCard(alignment: .center, backgroundColor: Color.card, border: false, style: PBCardStyle.default) {
          withoutShadow
        }
        Text("With Border")
          .pbFont(.caption, variant: .light, color: .text(.light))
          .padding(.trailing, 250)
          .padding(.top, 10)
        PBCard(alignment: .center, backgroundColor: Color.card, border: true, style: PBCardStyle.default) {
          withBorder
        }
      }
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Tab Bar")
  }
}

public extension TabBarCatalog {
  var dropShadow: some View {
    return HStack {
      PBTabBar(variant: .home)
      PBTabBar(variant: .calendar)
      //  PBTabBar(variant: .notifications)
      //  PBTabBar(variant: .search)
      PBTabBar(variant: .more)
    }
  }
  var withoutShadow: some View {
    return HStack {
      PBTabBar(variant: .home)
      PBTabBar(variant: .calendar)
      //   PBTabBar(variant: .notifications)
      PBTabBar(variant: .search)
      PBTabBar(variant: .more)
    }
  }
  var withBorder: some View {
    return HStack {
      PBTabBar(variant: .home)
      PBTabBar(variant: .calendar)
      PBTabBar(variant: .notifications)
      PBTabBar(variant: .search)
      PBTabBar(variant: .more)
    }
  }
}

//#Preview {
//    TabBarCatalog()
//}
