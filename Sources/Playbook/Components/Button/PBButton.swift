//
//  PBButtonStyle.swift
//
//
//  Created by Lucas C. Feijo on 16/07/21.
//

import SwiftUI

public struct PBButton: View {
  var variant: PBButtonVariant
  var disabled: Bool
  var size: PBButtonSize
  var shape: PBButtonShape
  var title: String?
  var icon: PBIcon?
  var iconPosition: PBIconPosition?
  let action: (() -> Void)?

  public init(
    variant: PBButtonVariant = .primary,
    disabled: Bool = false,
    size: PBButtonSize = .medium,
    shape: PBButtonShape = .primary,
    title: String? = nil,
    icon: PBIcon? = nil,
    iconPosition: PBIconPosition? = .left,
    action: (() -> Void)? = {}
  ) {
    self.variant = disabled == true ? .disabled : variant
    self.disabled = disabled
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
    .buttonStyle(
      PBButtonStyle(
        variant: variant,
        shape: shape,
        size: size,
        disabled: disabled
      )
    )
    .disabled(disabled)
  }

  public struct PBButtonStyle: ButtonStyle {
    var variant: PBButtonVariant
    var shape: PBButtonShape
    var size: PBButtonSize
    var disabled: Bool
    @State private var isHovering = false

    public func makeBody(configuration: Configuration) -> some View {
      let isPressed = configuration.isPressed
      let isPrimaryVariant = variant == .primary

      if shape == .circle {
        configuration.label
          .frame(minWidth: 38, minHeight: 38)
        #if os(macOS)
          .background(
            desktopBackgroundColor(for: configuration)
              .brightness(isPrimaryVariant && isPressed ? 0 : -0.04)
              .brightness(isPrimaryVariant && isHovering ? -0.04 : 0)
          )
          .foregroundColor(
            desktopForegroundColor(for: configuration)
          )
          .onHover { hovering in
            self.isHovering = hovering

            switch (isHovering, disabled) {
            case (true, false): NSCursor.pointingHand.set()
            case (true, true): NSCursor.operationNotAllowed.set()
            default: NSCursor.arrow.set()
            }
          }
        #endif
        #if os(iOS)
        .background(
          mobileBackgroundColor(for: configuration)
            .brightness(isPrimaryVariant && isPressed ? -0.04 : 0)
        )
        .foregroundColor(
          variant == .link && isPressed
            ? .pbTextDefault
            : foregroundColor(variant)
        )
        #endif
        .clipShape(Circle())
      } else {
        configuration.label
          .padding(.vertical, size.verticalPadding())
          .padding(.horizontal, size.horizontalPadding())
          .frame(minWidth: 0, minHeight: size.minHeight())
        #if os(macOS)
          .background(
            desktopBackgroundColor(for: configuration)
              .brightness(isPrimaryVariant && isPressed ? 0 : -0.04)
              .brightness(isPrimaryVariant && isHovering ? -0.04 : 0)
          )
          .foregroundColor(
            desktopForegroundColor(for: configuration)
          )
          .onHover { hovering in
            self.isHovering = hovering

            switch (isHovering, disabled) {
            case (true, false): NSCursor.pointingHand.set()
            case (true, true): NSCursor.operationNotAllowed.set()
            default: NSCursor.arrow.set()
            }
          }
        #endif
        #if os(iOS)
        .background(
          mobileBackgroundColor(for: configuration)
            .brightness(isPrimaryVariant && isPressed ? -0.04 : 0)
        )
        .foregroundColor(
          variant == .link && isPressed
            ? .pbTextDefault
            : foregroundColor(variant)
        )
        #endif
        .cornerRadius(5)
        .pbFont(.buttonText(size.fontSize))
      }
    }

    // iOS-specific functions
    private func mobileBackgroundColor(for configuration: Configuration) -> some View {
      configuration.isPressed ? mobilePressedBackgroundColor(variant) : backgroundColor(variant)
    }

    private func mobilePressedBackgroundColor(_ variant: PBButtonVariant) -> Color {
      switch variant {
      case .secondary: return .pbPrimary.opacity(0.3)
      case .link: return .clear
      default: return .pbPrimary
      }
    }

    // macOS-specific functions
    private func desktopBackgroundColor(for configuration: Configuration) -> Color {
      if configuration.isPressed {
        return backgroundColor(variant)
      } else if isHovering {
        return hoverBackgroundColor(variant)
      } else {
        return backgroundColor(variant)
      }
    }

    private func hoverBackgroundColor(_ variant: PBButtonVariant) -> Color {
      switch variant {
      case .secondary: return .pbPrimary.opacity(0.3)
      case .link: return .clear
      case .disabled: return .pbNeutral.opacity(0.5)
      default: return .pbPrimary
      }
    }

    private func desktopForegroundColor(for configuration: Configuration) -> Color {
      let isLinkVariant = variant == .link

      if isLinkVariant && configuration.isPressed {
        return .pbPrimary
      } else if isLinkVariant && isHovering {
        return .pbTextDefault
      } else {
        return foregroundColor(variant)
      }
    }

    // OS-agnostic functions
    private func backgroundColor(_ variant: PBButtonVariant) -> Color {
      switch variant {
      case .secondary: return .pbPrimary.opacity(0.05)
      case .link: return .clear
      case .disabled: return .pbNeutral.opacity(0.5)
      default: return .pbPrimary
      }
    }

    private func foregroundColor(_ variant: PBButtonVariant) -> Color {
      switch variant {
      case .primary: return .white
      case .disabled: return .pbTextDefault.opacity(0.5)
      default: return .pbPrimary
      }
    }
  }
}

public enum PBButtonVariant {
  case primary
  case secondary
  case link
  case disabled
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

public enum PBButtonShape {
  case primary
  case circle
}

public enum PBIconPosition {
  case left
  case right
}

@available(macOS 13.0, *)
struct PBButtonStyle_Previews: PreviewProvider {
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
          action: {})
        PBButton(
          variant: .link,
          title: "Button Link",
          action: {}
        )
        PBButton(disabled: true, title: "Button Disabled")
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
            disabled: true,
            shape: .circle,
            icon: PBIcon.fontAwesome(.times, size: .x1),
            action: {}
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
