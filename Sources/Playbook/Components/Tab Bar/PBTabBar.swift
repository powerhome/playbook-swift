//
//  PBTabBar.swift
//  
//
//  Created by Rachel Radford on 12/15/23.
//

import SwiftUI

public struct PBTabBar: View {
  @Binding var selectedTab: Int
  let hasBorder: Bool?
  let hasShadow: Bool?
  var icon: [FontAwesome]
  var iconName: [String]
  public init(
    selectedTab: Binding<Int> = .constant(0),
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
    PBCard(alignment: .center, backgroundColor: Color.card, border: hasBorder ?? false, style: PBCardStyle.default, shadow: hasShadow ?? false ? .deep : Shadow.none) {
      HStack {
        tabButtonView
      }
    }.shadow(color: hasShadow ?? false ? .shadow.opacity(0.74) : Color.clear, radius: 4, x: 4, y: 0)
  }
}

public extension PBTabBar {
  var tabButtonView: some View {
    return ForEach(Array(zip(icon, iconName)), id: \.self.0) { (image, name) in
      Spacer()
      Button {
        selectedTab = image.hashValue
      } label: {
          VStack(spacing: Spacing.xxSmall) {
            PBIcon(image, size: .large)
            Text(name)
          }
          .pbFont(.subcaption, color: selectedTab == image.hashValue ? Color.pbPrimary : Color.text(.light)
          ).padding(.horizontal, -5)
      }
      .buttonStyle(.plain)
      .padding(.bottom, Spacing.large)
      .frame(maxWidth: .infinity, alignment: .bottom)
      .frame(height: 48)
      Spacer()
    }
  }
}

#Preview {
  registerFonts()
  return TabBarCatalog()
}
