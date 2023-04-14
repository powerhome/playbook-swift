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

public enum PBButtonVariant {
  case primary
  case secondary
  case link
  case disabled
}

public enum PBButtonShape {
  case primary
  case circle
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
        PBButton(
          title: "Button Primary",
          action: {}
        )
        PBButton(
          variant: .secondary,
          title: "Button Secondary",
          action: {}
        )
        PBButton(
          variant: .link,
          title: "Button Link",
          action: {}
        )
        PBButton(
          variant: .disabled,
          title: "Button Disabled"
        )
      }
      .listRowSeparator(.hidden)

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
        HStack {
          PBButton(
            shape: .circle,
            icon: PBIcon.fontAwesome(.plus, size: .x1),
            action: {}
          )
          PBButton(
            variant: .secondary,
            shape: .circle,
            icon: PBIcon.fontAwesome(.pen, size: .x1),
            action: {}
          )
          PBButton(
            variant: .disabled,
            shape: .circle,
            icon: PBIcon.fontAwesome(.times, size: .x1)
          )
          PBButton(
            variant: .link,
            shape: .circle,
            icon: PBIcon.fontAwesome(.user, size: .x1),
            action: {}
          )
        }
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
