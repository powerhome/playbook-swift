//
//  PBButtonStyle.swift
//
//
//  Created by Lucas C. Feijo on 16/07/21.
//

import SwiftUI

public struct PBButton: View {
  var variant: PBButtonVariant
  var size: PBButtonSize
  var shape: PBButtonShape
  var title: String?
  var icon: PBIcon?
  var iconPosition: PBIconPosition?
  let action: (() -> Void)?

  public init(
    variant: PBButtonVariant = .primary,
    size: PBButtonSize = .medium,
    shape: PBButtonShape = .primary,
    title: String? = nil,
    icon: PBIcon? = nil,
    iconPosition: PBIconPosition? = .left,
    action: (() -> Void)? = {}
  ) {
    self.variant = variant
    self.size = size
    self.shape = shape
    self.title = title
    self.icon = icon
    self.iconPosition = iconPosition
    self.action = action
  }

  public var body: some View {
    Button {
      action?()
    } label: {
      HStack {
        if let icon, iconPosition == .left {
          icon
        }

        if let title = title, shape == .primary {
          Text(title)
        }

        if let icon, iconPosition == .right {
          icon
        }
      }
    }
    .customButtonStyle(
      variant: variant,
      shape: shape,
      size: size
    )
    .disabled(variant == .disabled ? true : false)
  }
}

extension Button {
  @ViewBuilder
  func customButtonStyle(
    variant: PBButtonVariant,
    shape: PBButtonShape,
    size: PBButtonSize
  ) -> some View {
    switch shape {
    case .primary:
      self.buttonStyle(
        PBButtonStyle(
          variant: variant,
          shape: shape,
          size: size
        )
      )
    case .circle:
      self.buttonStyle(
        PBCircleButtonStyle(
          variant: variant,
          shape: shape,
          size: size
        )
      )
    }
  }
}

extension View {
  func primaryVariantBrightness(
    isPrimaryVariant: Bool,
    isPressed: Bool,
    isHovering: Bool
  ) -> some View {
    let isPrimaryPressed = isPrimaryVariant && isPressed
    let isPrimaryHovered = isPrimaryVariant && isHovering

    #if os(macOS)
      return self.brightness(isPrimaryPressed ? 0 : -0.04)
        .brightness(isPrimaryHovered ? -0.04 : 0)
    #else
      return self.brightness(isPrimaryPressed ? 0 : -0.04)
    #endif
  }
}

public enum PBButtonVariant {
  case primary
  case secondary
  case link
  case disabled

  // Color configuations
  public var backgroundColor: Color {
    switch self {
    case .secondary: return .pbPrimary.opacity(0.05)
    case .link: return .clear
    case .disabled: return .pbNeutral.opacity(0.5)
    default: return .pbPrimary
    }
  }

  public var foregroundColor: Color {
    switch self {
    case .primary: return .white
    case .disabled: return .pbTextDefault.opacity(0.5)
    default: return .pbPrimary
    }
  }

  // iOS-specific animations
  public var mobilePressedBackgroundColor: Color {
    switch self {
    case .secondary: return .pbPrimary.opacity(0.3)
    case .link: return .clear
    default: return .pbPrimary
    }
  }

  // macOS-specific animations
  public var hoverBackgroundColor: Color {
    switch self {
    case .secondary: return .pbPrimary.opacity(0.3)
    case .link: return .clear
    case .disabled: return .pbNeutral.opacity(0.5)
    default: return .pbPrimary
    }
  }

  // Animation functions
  public func backgroundAnimation(
    configuration: ButtonStyleConfiguration,
    variant: PBButtonVariant,
    isHovering: Bool
  ) -> Color {
    let isPressed = configuration.isPressed

    #if os(macOS)
      if isPressed {
        return variant.backgroundColor
      } else if isHovering {
        return variant.hoverBackgroundColor
      } else {
        return variant.backgroundColor
      }
    #else
      return isPressed
        ? variant.mobilePressedBackgroundColor
        : variant.backgroundColor
    #endif
  }

  public func foregroundAnimation(
    configuration: ButtonStyleConfiguration,
    variant: PBButtonVariant,
    isHovering: Bool
  ) -> Color {
    let isLinkVariant = variant == .link
    let isPressed = configuration.isPressed

    #if os(macOS)
      if isLinkVariant && isPressed {
        return .pbPrimary
      } else if isLinkVariant && isHovering {
        return .pbTextDefault
      } else {
        return variant.foregroundColor
      }
    #else
      return isLinkVariant && isPressed
        ? .pbTextDefault
        : variant.foregroundColor
    #endif
  }
}

public enum PBButtonShape {
  case primary
  case circle
}

public enum PBButtonSize {
  case small
  case medium
  case large

  public var fontSize: CGFloat {
    switch self {
    case .small:
      return 12
    case .medium:
      return 14
    case .large:
      return 18
    }
  }

  func verticalPadding() -> CGFloat {
    return fontSize / 2
  }

  func horizontalPadding() -> CGFloat {
    return fontSize * 2.42
  }

  func minHeight() -> CGFloat {
    return self == .small ? 36 : 40
  }
}

public enum PBIconPosition {
  case left
  case right
}

@available(macOS 13.0, *)
struct PBButton_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return List {
      Section("Button Variants") {
        PBButtonStyle_Previews.previews
      }

      Section("Button Icon Positions") {
        PBButton(
          title: "Button with Icon on Left",
          icon: PBIcon.fontAwesome(.user, size: .x1),
          action: {}
        )
        PBButton(
          title: "Button with Icon on Right",
          icon: PBIcon.fontAwesome(.user, size: .x1),
          iconPosition: .right,
          action: {}
        )
      }
      .listRowSeparator(.hidden)

      Section("Circle Buttons") {
        PBCircleStyle_Previews.previews
      }

      Section("Button Sizes") {
        PBButton(
          size: .small,
          title: "Button sm",
          action: {}
        )
        PBButton(
          title: "Button md",
          action: {}
        )
        PBButton(
          size: .large,
          title: "Button lg",
          action: {}
        )
      }
      .listRowSeparator(.hidden)
    }
  }
}
