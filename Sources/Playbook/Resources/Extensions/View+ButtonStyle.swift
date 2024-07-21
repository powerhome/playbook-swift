//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  View+ButtonStyle.swift
//

import SwiftUI

public struct PBButtonStyle: ButtonStyle {
  var variant: Variant
  var size: Size
  @State private var isHovering = false
  
  public func makeBody(configuration: Configuration) -> some View {
    let isPressed = configuration.isPressed
    let isPrimaryVariant = variant == .primary
    configuration.label
      .background(
        variant
          .backgroundAnimation(
            configuration: configuration,
            isHovering: isHovering
          )
          .primaryVariantBrightness(
            isPrimaryVariant: isPrimaryVariant,
            isPressed: isPressed,
            isHovering: isHovering
          )
      )
      .foregroundColor(
        variant
          .foregroundAnimation(
            configuration: configuration,
            isHovering: isHovering
          )
      )
    
      .onHover(disabled: variant == .disabled ? true : false) {
        self.isHovering = $0
      }
      .pbFont(size.fontSize, color: variant.foregroundColor)
    
  }
}

public extension PBButtonStyle {
  enum Variant {
    case primary
    case secondary
    case link
    case disabled
    
    // Color configuations
    var backgroundColor: Color {
      switch self {
      case .secondary: return .pbPrimary.opacity(0.05)
      case .link: return .clear
      case .disabled: return .status(.neutral).opacity(0.5)
      default: return .pbPrimary
      }
    }
    
    var foregroundColor: Color {
      switch self {
      case .primary: return .white
      case .disabled: return .text(.default).opacity(0.5)
      default: return .pbPrimary
      }
    }
    
    // iOS-specific colors
    var mobilePressedBackgroundColor: Color {
      switch self {
      case .secondary: return .pbPrimary.opacity(0.3)
      case .link: return .clear
      default: return .pbPrimary
      }
    }
    
    // macOS-specific colors
    var hoverBackgroundColor: Color {
      switch self {
      case .secondary: return .pbPrimary.opacity(0.3)
      case .link: return .clear
      case .disabled: return .status(.neutral).opacity(0.5)
      default: return .pbPrimary
      }
    }
    
    // Animation functions
    func backgroundAnimation(
      configuration: ButtonStyleConfiguration,
      isHovering: Bool
    ) -> Color {
      let isPressed = configuration.isPressed
      
#if os(macOS)
      if isPressed {
        return self.backgroundColor
      } else if isHovering {
        return self.hoverBackgroundColor
      } else {
        return self.backgroundColor
      }
#else
      return isPressed
      ? self.mobilePressedBackgroundColor
      : self.backgroundColor
#endif
    }
    
    func foregroundAnimation(
      configuration: ButtonStyleConfiguration,
      isHovering: Bool
    ) -> Color {
      let isLinkVariant = self == .link
      let isPressed = configuration.isPressed
      
      #if os(macOS)
      if isLinkVariant && isPressed {
        return .pbPrimary
      } else if isLinkVariant && isHovering {
        return .text(.default)
      } else {
        return self.foregroundColor
      }
      #else
      return isLinkVariant && isPressed
      ? .text(.default)
      : self.foregroundColor
      #endif
    }
  }
  enum Size {
    case small
    case medium
    case large
    case `default`
  
    public var fontSize: PBFont {
      switch self {
      case .small:
        return .buttonText(12)
      case .medium:
        return .buttonText(14)
      case .large:
        return .buttonText(18)
      case .default: return .buttonText(16)
      }
    }
  }
}

