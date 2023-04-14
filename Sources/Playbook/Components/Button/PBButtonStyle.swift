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
      .background(
        backgroundForDevice(for: configuration)
        #if os(macOS)
          .brightness(isPrimaryVariant && isPressed ? 0 : -0.04)
          .brightness(isPrimaryVariant && isHovering ? -0.04 : 0)
        #else
          .brightness(isPrimaryVariant && isPressed ? 0 : -0.04)
        #endif
      )
      .foregroundColor(
        foregroundForDevice(
          for: configuration,
          variant: variant,
          isHovering: isHovering
        )
      )
      .cornerRadius(5)
    #if os(macOS)
      .onHover(disabled: variant == .disabled ? true : false) { isHovering in
        self.isHovering = isHovering
      }
    #endif
      .pbFont(.buttonText(size.fontSize))
  }

  // Color configuations
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

  // Animation functions
  private func backgroundForDevice(for configuration: Configuration) -> Color {
    let isPressed = configuration.isPressed

    #if os(macOS)
      if isPressed {
        return backgroundColor(variant)
      } else if isHovering {
        return hoverBackgroundColor(variant)
      } else {
        return backgroundColor(variant)
      }
    #else
      return isPressed
        ? mobilePressedBackgroundColor(variant)
        : backgroundColor(variant)
    #endif
  }

  private func foregroundForDevice(
    for configuration: Configuration,
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
        return foregroundColor(variant)
      }
    #else
      return isLinkVariant && isPressed
        ? .pbTextDefault
        : foregroundColor(variant)
    #endif
  }

  // iOS-specific animations
  private func mobilePressedBackgroundColor(_ variant: PBButtonVariant) -> Color {
    switch variant {
    case .secondary: return .pbPrimary.opacity(0.3)
    case .link: return .clear
    default: return .pbPrimary
    }
  }

  // macOS-specific animations
  private func hoverBackgroundColor(_ variant: PBButtonVariant) -> Color {
    switch variant {
    case .secondary: return .pbPrimary.opacity(0.3)
    case .link: return .clear
    case .disabled: return .pbNeutral.opacity(0.5)
    default: return .pbPrimary
    }
  }
}

@available(macOS 13.0, *)
public struct PBButtonStyle_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()

    return VStack(alignment: .leading) {
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
      PBButton(
        variant: .disabled,
        title: "Button Disabled"
      )
    }
    .listRowSeparator(.hidden)
    .previewDisplayName("Button Variants")
  }
}
