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
        icon

        if let title = title, shape == .primary {
          Text(title)
        }
      }
      .environment(\.layoutDirection, iconPosition == .left ? .leftToRight : .rightToLeft)
    }
    .customButtonStyle(
      variant: variant,
      shape: shape,
      size: size
    )
    .disabled(variant == .disabled ? true : false)
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
    switch self {
    case .small:
      return 30
    case .medium:
      return 40
    case .large:
      return 45
    }
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
    return ButtonsCatalog()
  }
}
