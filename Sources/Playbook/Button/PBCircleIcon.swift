//
//  PBCircleIcon.swift
//  
//
//  Created by Everton Cunha on 11/05/22.
//

import SwiftUI

public struct PBCircleIcon: View {
  var icon: PBIcon
  var variant: PBCircleIcon.Variant

  public init(icon: PBIcon, variant: PBCircleIcon.Variant) {
    self.icon = icon
    self.variant = variant
  }

  public var body: some View {
    icon
      .frame(minWidth: 38, minHeight: 38)
      .background(variant.backgroundColor)
      .foregroundColor(variant.foregroundColor)
      .pbFont(.buttonText())
      .clipShape(Circle())
  }
}

// MARK: - Variant enum

public extension PBCircleIcon {
  enum Variant {
    case secondary

    var backgroundColor: Color {
      switch self {
      case .secondary:
        return PBColor.primary.color.opacity(0.05)
      }
    }

    var foregroundColor: Color {
      switch self {
      case .secondary:
        return PBColor.primary.color
      }
    }
  }
}

// MARK: - Preview

struct PBCircleIcon_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return VStack {
      VStack {
          PBCircleIcon(icon: PBIcon(FontAwesome.plus, size: .small), variant: .secondary)
      }
      .background(Color.pbBackground)
    }
  }
}
