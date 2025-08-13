//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTabBar.swift
//

import SwiftUI

public struct PBTabBar: View {
  @Binding var selectedTab: Int?
  let border: Bool
  let shadow: Bool
  var icons: [TabIcon]

  public init(
    selectedTab: Binding<Int?> = .constant(0),
    border: Bool = false,
    shadow: Bool = false,
    icons: [TabIcon] = []
  ) {
    self._selectedTab = selectedTab
    self.border = border
    self.shadow = shadow
    self.icons = icons
  }

  public var body: some View {
    PBCard(
      alignment: .center,
      border: border,
      borderRadius: BorderRadius.none,
      padding: Spacing.none,
      shadow: Shadow.none
    ) {
      HStack {
        withAnimation(.easeIn) {
          tabButtonView
        }
      }
      .padding(.horizontal, Spacing.xSmall)
      .padding(.top, Spacing.xSmall)
      .padding(.bottom, Spacing.large)
    }
    .shadow(color: shadowColor, radius: 10, x: 0, y: -4)
  }
}

public extension PBTabBar {
  var tabButtonView: some View {
    return ForEach(Array(zip(icons.indices, icons)), id: \.self.0) { (index, icon) in
      Spacer()
      Button {
        selectedTab = index
      } label: {
        TabIcon(icon: icon.icon, name: icon.name, color: iconColor(index))
      }
      .buttonStyle(.plain)
      Spacer()
    }
  }

  var shadowColor: Color {
      return shadow ? .shadow.opacity(0.2) : .clear
    }

  func iconColor(_ index: Int) -> Color {
      selectedTab == index ? Color.pbPrimary : Color.text(.light)
    }
}

public struct TabIcon: View {
  var icon: FontAwesome
  var name: String
  var color: Color

 public init(
    icon: FontAwesome = .home,
    name: String = "",
    color: Color = .text(.light)
  ) {
    self.icon = icon
    self.name = name
    self.color = color
  }

  public var body: some View {
    VStack(spacing: Spacing.xxSmall) {
      PBIcon(icon, size: .large)
      Text(name)
    }
    .pbFont(.subcaption, color: color)
  }
}

//#Preview {
//  registerFonts()
//  return TabBarCatalog()
//}
