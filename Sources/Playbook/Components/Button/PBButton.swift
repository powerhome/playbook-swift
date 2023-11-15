//
//  PBButtonStyle.swift
//
//
//  Created by Lucas C. Feijo on 16/07/21.
//

import SwiftUI

public struct PBButton: View {
  var fullWidth: Bool
  var variant: Variant
  var size: Size
  var shape: Shape
  var title: String?
  var icon: PBIcon?
  var iconPosition: IconPosition?
  let action: (() -> Void)?

  public init(
    fullWidth: Bool = false,
    variant: Variant = .primary,
    size: Size = .medium,
    shape: Shape = .primary,
    title: String? = nil,
    icon: PBIcon? = nil,
    iconPosition: IconPosition? = .left,
    action: (() -> Void)? = {}
  ) {
    self.fullWidth = fullWidth
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
        icon

        if let title = title, shape == .primary {
          Text(title)
        }
      }
      .environment(\.layoutDirection, iconPosition == .left ? .leftToRight : .rightToLeft)
      .frame(maxWidth: fullWidth ? .infinity : nil)
    }
    .customButtonStyle(
      variant: variant,
      shape: shape,
      size: size
    )
    .disabled(variant == .disabled ? true : false)
  }
}

public extension PBButton {
  enum Shape {
    case primary
    case circle
  }

  enum Size {
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

    func verticalPadding(_ variant: PBButton.Variant) -> CGFloat {
      return variant == .link ? 0 : fontSize / 2
    }

    func horizontalPadding(_ variant: PBButton.Variant) -> CGFloat {
      return variant == .link ? 0 : fontSize * 2.42
    }

    func minHeight(_ variant: PBButton.Variant) -> CGFloat {
      if variant != .link {
        switch self {
        case .small:
          return 30
        case .medium:
          return 40
        case .large:
          return 45
        }
      } else {
        return 0
      }
    }
  }

  enum IconPosition {
    case left
    case right
  }
}

private struct PBButton_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return ButtonsCatalog()
  }
}
