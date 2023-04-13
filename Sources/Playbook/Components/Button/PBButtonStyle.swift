//
//  SwiftUIView.swift
//
//
//  Created by Gavin Huang on 4/11/23.
//

import SwiftUI

public struct PBButtonStyle: ButtonStyle {
  var variant: PBButtonVariant
  var shape: PBButtonShape
  var size: PBButtonSize
  @State private var isHovering = false

  public func makeBody(configuration: Configuration) -> some View {
    let isPressed = configuration.isPressed
    let isPrimaryVariant = variant == .primary

    configuration.label
      .padding(.vertical, size.verticalPadding())
      .padding(.horizontal, size.horizontalPadding())
      .frame(minWidth: 0, minHeight: size.minHeight())
    #if os(macOS)
      .background(
        desktopBackgroundColor(for: configuration)
          .brightness(isPrimaryVariant && isPressed ? 0 : -0.04)
          .brightness(isPrimaryVariant && isHovering ? -0.04 : 0))
      .foregroundColor(
        desktopForegroundColor(for: configuration)
      )
      .onHover(disabled: variant == .disabled ? true : false) { isHovering in
        self.isHovering = isHovering
      }
    #endif
    #if os(iOS)
    .background(mobileBackgroundColor(for: configuration))
    .foregroundColor(
      variant == .link && isPressed
        ? .pbTextDefault
        : foregroundColor(variant)
    )
    #endif
    .cornerRadius(5)
    .pbFont(.buttonText(size.fontSize))
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

  // General functions
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
        PBButton(title: "Button Disabled")
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

    }
  }
}
