//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  DesignElements.swift
//

import SwiftUI

public enum DesignElements: String, CaseIterable {
  case borderRadius, color, iconography, spacing, shadows, typography
  public static let title: String = "Design Elements"

  @ViewBuilder
  public var destination: some View {
    switch self {
    case .borderRadius: BorderRadiusCatalog()
    case .color: ColorCatalog()
    case .iconography: Iconography()
    case .spacing: SpacingCatalog()
    case .shadows: PBShadow_Previews.previews
    case .typography: TypographyCatalog()
    }
  }

  public var icon: FontAwesome {
    switch self {
    case .borderRadius: return .borderStyle
    case .color: return .palette
    case .iconography: return .icons
    case .spacing: return .spaceShuttle
    case .shadows: return .cloud
    case .typography: return .textHeight
    }
  }
}
