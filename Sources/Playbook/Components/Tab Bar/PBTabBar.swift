//
//  PBTabBar.swift
//  
//
//  Created by Rachel Radford on 12/15/23.
//

import SwiftUI

public struct PBTabBar: View {
  @Binding var selectedTab: String
  let hasBorder: Bool?
  let hasShadow: Bool?
  var icon: [FontAwesome]
  var iconName: [String]
  public init(
    selectedTab: Binding<String> = .constant(""),
    hasBorder: Bool = false,
    hasShadow: Bool = false,
    icon: [FontAwesome] = [(.home)],
    iconName: [String] = [""]
  ) {
    self._selectedTab = selectedTab
    self.hasBorder = hasBorder
    self.hasShadow = hasShadow
    self.icon = icon
    self.iconName = iconName
  }
  
  public var body: some View {
    PBCard(alignment: .center, backgroundColor: Color.card, border: hasBorder ?? false, borderRadius: BorderRadius.none, style: PBCardStyle.default, shadow: Shadow.none) {
      HStack {
        withAnimation(.easeIn) {
          tabButtonView
        }
        
      }
      .padding(.leading, -Spacing.small)
      .padding(.trailing, -Spacing.small)
      .padding(.top, -Spacing.xxSmall)
      .padding(.bottom, -Spacing.small)
    }.shadow(color: hasShadow ?? false ? .shadow.opacity(0.74) : Color.clear, radius: 10, x: 0, y: -4)
  }
}

public extension PBTabBar {
  var tabButtonView: some View {
    return ForEach(Array(zip(icon, iconName)), id: \.self.0) { (image, name) in
      Spacer()
      Button {
        selectedTab = image.rawValue
      } label: {
        TabIcon(iconImageName: image, iconName: name, iconSize: .large)
          .pbFont(.subcaption, color: selectedTab == image.rawValue ? Color.pbPrimary : Color.text(.light)
          )
          .padding(.horizontal, -5)
          .onAppear {
            selectedTab = "fa-home"
          }
      }
      .buttonStyle(.plain)
      .padding(.bottom, Spacing.large)
      .frame(height: 48)
      
      Spacer()
    }
  }
}

struct TabIcon: View {
  var iconImageName: FontAwesome
  var iconName: String
  var iconSize: PBIcon.IconSize
  init(
    iconImageName: FontAwesome = .home,
    iconName: String = "",
    iconSize: PBIcon.IconSize = .large
  ) {
    self.iconImageName = iconImageName
    self.iconName = iconName
    self.iconSize = iconSize
  }
  
  var body: some View {
    VStack(spacing: Spacing.xxSmall) {
      PBIcon(iconImageName, size: iconSize)
      Text(iconName)
    }
  }
}

#Preview {
  registerFonts()
  return TabBarCatalog()
}
