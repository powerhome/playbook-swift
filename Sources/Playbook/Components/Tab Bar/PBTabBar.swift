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
    PBCard(alignment: .center, backgroundColor: Color.card, border: hasBorder ?? false, style: PBCardStyle.default, shadow: hasShadow ?? false ? .deep : Shadow.none) {
      HStack {
        withAnimation(.easeIn) {
          tabButtonView
        }
        
      }
    }.shadow(color: hasShadow ?? false ? .shadow.opacity(0.74) : Color.clear, radius: 4, x: 4, y: 0)
  }
}

public extension PBTabBar {
  var tabButtonView: some View {
    return ForEach(Array(zip(icon, iconName)), id: \.self.0) { (image, name) in
      Spacer()
      Button {
        selectedTab = image.rawValue
      } label: {
        TabButtonLabel(iconImageName: image, iconName: name)
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

struct TabButtonLabel: View {
  var iconImageName: FontAwesome
  var iconName: String
  init(
    iconImageName: FontAwesome = .home,
    iconName: String = ""
  ) {
    self.iconImageName = iconImageName
    self.iconName = iconName
  }
  
  var body: some View {
    VStack(spacing: Spacing.xxSmall) {
      PBIcon(iconImageName, size: .large)
      Text(iconName)
    }
  }
}

#Preview {
  registerFonts()
  return TabBarCatalog()
}
