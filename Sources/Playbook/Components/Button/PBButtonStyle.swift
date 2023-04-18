//
//  PBButtonStyle.swift
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
        backgroundForDevice(for: configuration, variant: variant)
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

  // Animation functions
  private func backgroundForDevice(for configuration: Configuration, variant: PBButtonVariant) -> Color {
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
        return variant.foregroundColor
      }
    #else
      return isLinkVariant && isPressed
        ? .pbTextDefault
        : variant.foregroundColor
    #endif
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
