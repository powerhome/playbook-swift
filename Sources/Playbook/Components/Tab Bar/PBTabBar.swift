//
//  PBTabBar.swift
//  
//
//  Created by Rachel Radford on 12/15/23.
//

import SwiftUI

public struct PBTabBar: View {
  @State var isTabSelected: Bool = false
  var tabIconCount: Int = 0
  let hasBorder: Bool?
  let hasShadow: Bool?
  var icon: [PBIcon]
  var iconName: FontAwesome
  public init(
    tabIconCount: Int = 0,
    hasBorder: Bool = false,
    hasShadow: Bool = false,
    icon: [PBIcon] = [PBIcon.fontAwesome(.home, size: .large)],
    iconName: FontAwesome = .home
  ) {
    self.tabIconCount = tabIconCount
    self.hasBorder = hasBorder
    self.hasShadow = hasShadow
    self.icon = icon
    self.iconName = iconName
  }
  
  public var body: some View {
    PBCard(alignment: .center, backgroundColor: Color.card, border: hasBorder ?? false, style: PBCardStyle.default, shadow: hasShadow ?? false ? .deep : Shadow.none) {
      HStack(spacing: Spacing.xLarge) {
        ForEach(0..<tabIconCount, id: \.description) { _ in
          tabButtonView
            .frame(maxWidth: .infinity)
            .foregroundStyle(tabIconColor)
        }
      }
      .frame(maxWidth: .infinity, alignment: .bottom)
      .frame(height: 48)
    }
  }
}

public extension PBTabBar {
  var tabButtonView: some View {
    return Button {
      isTabSelected.toggle()
      
    } label: {
      tabButtonLabelView
    }
    .buttonStyle(.plain)
    .pbFont(.subcaption, color: tabIconColor)
    .padding(.bottom, Spacing.large)
  }
  @ViewBuilder
  var tabButtonLabelView: some View {
    VStack(spacing: Spacing.xxSmall) {
      tabIconView
      Text(tabIconNameView)
    }
  }
  var tabIconView: PBIcon {
    return PBIcon(iconName, size: .large)
  }
  var tabIconNameView: String {
    return iconName.rawValue.replacingOccurrences(of: "fa-", with: "")
  }
  var tabIconColor: Color {
    return isTabSelected == true ? Color.pbPrimary : Color.text(.light)
  }
}

#Preview {
  registerFonts()
  return TabBarCatalog()
}
