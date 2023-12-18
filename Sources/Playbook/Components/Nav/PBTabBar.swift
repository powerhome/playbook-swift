//
//  PBTabBar.swift
//  
//
//  Created by Rachel Radford on 12/15/23.
//

import SwiftUI

public struct PBTabBar: View {
  let icon: FontAwesome?
  let iconSize: PBIcon.IconSize?
  let tabBarIconName: String?
  @State private var isSelected: Bool
  @Binding var selectedTabDefault: Bool
  let variant: Variant
  public init(
    icon: FontAwesome? = nil,
    iconSize: PBIcon.IconSize? = nil,
    tabBarIconName: String? = nil,
    isSelected: Bool = false,
    selectedTabDefault: Binding<Bool> = .constant(false),
    variant: Variant = .home
  ) {
    self.icon = icon
    self.iconSize = iconSize
    self.tabBarIconName = tabBarIconName
    self.isSelected = isSelected
    _selectedTabDefault = selectedTabDefault
    self.variant = variant
  }
  
  public var body: some View {
    tabButtonView
  }
}
public extension PBTabBar {
  enum Variant {
    case home, calendar, notifications, search, more
  }
  
  var tabButtonView: some View {
    return HStack {
      Button {
        isSelected.toggle()
      } label: {
        tabButtonLabelView
      }
    }.padding(.bottom, Spacing.large)
  }
  var tabButtonLabelView: some View {
    return  GeometryReader { geo in
      VStack(spacing: Spacing.xxSmall) {
        tabIconView
        tabIconNameView
      } .pbFont(.subcaption, color: tabIconColor)
        .frame(width: geo.size.width * 1.0, height: geo.size.height)
    }
  }
  var tabIconView: PBIcon {
    switch variant {
    case .home: return PBIcon(FontAwesome.home, size: .large)
    case .calendar: return PBIcon(FontAwesome.calendar, size: .large)
    case .notifications: return PBIcon(FontAwesome.bell, size: .large)
    case .search: return PBIcon(FontAwesome.search, size: .large)
    case .more: return PBIcon(FontAwesome.ellipsisH, size: .large)
    }
  }
  var tabIconNameView: Text {
    switch variant {
    case .home: return Text("Home")
    case .calendar: return Text("Calendar")
    case .notifications: return Text("Notifications")
    case .search: return Text("Search")
    case .more: return Text("More")
    }
  }
  var tabIconColor: Color {
    return isSelected == true ? Color.pbPrimary : Color.text(.light)
  }
}

#Preview {
  registerFonts()
  return PBTabBar()
}
