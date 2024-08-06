//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBButtonVariant.swift
//

import SwiftUI

public extension PBButton {
  enum Variant {
    case primary
    case secondary
    case link
    case disabled

    // Color configuations
      public func  backgroundColor(colorScheme: ColorScheme) -> Color {
      switch self {
      case .secondary: return Color.Buttons.Secondary.background(colorScheme)
      case .link: return .clear
      case .disabled: return .status(.neutral).opacity(0.5)
      default: return .pbPrimary
      }
    }

      public func foregroundColor(colorScheme: ColorScheme) -> Color {
      switch self {
      case .primary: return .white
      case .secondary: return Color.Buttons.Secondary.foreground(colorScheme)
      case .disabled: return .text(.default).opacity(0.5)
      default: return .pbPrimary
      }
    }

    // iOS-specific colors
    public var mobilePressedBackgroundColor: Color {
      switch self {
      case .secondary: return .pbPrimary.opacity(0.3)
      case .link: return .clear
      default: return .pbPrimary
      }
    }

    // macOS-specific colors
    public var hoverBackgroundColor: Color {
      switch self {
      case .secondary: return .pbPrimary.opacity(0.3)
      case .link: return .clear
      case .disabled: return .status(.neutral).opacity(0.5)
      default: return .pbPrimary
      }
    }

    // Animation functions
    public func backgroundAnimation(
      configuration: ButtonStyleConfiguration,
      isHovering: Bool,
      colorScheme: ColorScheme
    ) -> Color {
      let isPressed = configuration.isPressed

      #if os(macOS)
      if isPressed {
        return self.backgroundColor(colorScheme: colorScheme)
      } else if isHovering {
        return self.hoverBackgroundColor
      } else {
        return self.backgroundColor(colorScheme: colorScheme)
      }
      #else
      return isPressed
      ? self.mobilePressedBackgroundColor
      : self.backgroundColor
      #endif
    }
      
    public func foregroundAnimation(
      configuration: ButtonStyleConfiguration,
      isHovering: Bool,
      colorScheme: ColorScheme
    ) -> Color {
      let isLinkVariant = self == .link
      let isPressed = configuration.isPressed

      #if os(macOS)
      if isLinkVariant && isPressed {
        return .pbPrimary
      } else if isLinkVariant && isHovering {
        return .text(.default)
      } else {
        return self.foregroundColor(colorScheme: colorScheme)
      }
      #else
      return isLinkVariant && isPressed
      ? .text(.default)
      : self.foregroundColor
      #endif
    }
  }
}
