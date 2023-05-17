//
//  File.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public enum DesignElements: String, CaseIterable {
  case color, shadows, typography, iconography, spacing
  public static let title: String = "Design Elements"

  @ViewBuilder
  public var destination: some View {
    switch self {
    case .color: ColorsCatalog()
    case .shadows: PBShadow_Previews.previews
    case .typography: Typography_Previews.previews
    case .iconography: IconCatalog()
    case .spacing: EmptyView()
    }
  }

  public var icon: FontAwesome {
    switch self {
    case .color: return .palette
    case .shadows: return .cloud
    case .typography: return .textHeight
    case .iconography: return .icons
    case .spacing: return .spaceShuttle
    }
  }
}
