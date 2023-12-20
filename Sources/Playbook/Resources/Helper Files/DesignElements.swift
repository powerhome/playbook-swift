//
//  DesignElements.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

@available(macOS 13.0, *)
public enum DesignElements: String, CaseIterable {
  case borderRadius, color, iconography, spacing, shadows, typography
  public static let title: String = "Design Elements"

  @ViewBuilder
  public var destination: some View {
    switch self {
    case .borderRadius: BorderRadiusCatalog()
    case .color: ColorsCatalog()
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
