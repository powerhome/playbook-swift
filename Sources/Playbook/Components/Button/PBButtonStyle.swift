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
        variant.backgroundForDevice(
          configuration: configuration,
          variant: variant,
          isHovering: isHovering
        )
        #if os(macOS)
        .brightness(isPrimaryVariant && isPressed ? 0 : -0.04)
        .brightness(isPrimaryVariant && isHovering ? -0.04 : 0)
        #else
        .brightness(isPrimaryVariant && isPressed ? 0 : -0.04)
        #endif
      )
      .foregroundColor(
        variant.foregroundForDevice(
          configuration: configuration,
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
