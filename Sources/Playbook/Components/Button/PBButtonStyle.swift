//
//  PBButtonStyle.swift
//
//
//  Created by Gavin Huang on 4/11/23.
//

import SwiftUI

public struct PBButtonStyle: ButtonStyle {
  var variant: PBButtonVariant
  var size: PBButton.Size
  @State private var isHovering = false

  public init(
    variant: PBButtonVariant,
    size: PBButton.Size) {
    self.variant = variant
    self.size = size
  }

  public func makeBody(configuration: Configuration) -> some View {
    let isPressed = configuration.isPressed
    let isPrimaryVariant = variant == .primary

    configuration.label
      .padding(.vertical, size.verticalPadding(variant))
      .padding(.horizontal, size.horizontalPadding(variant))
      .frame(minWidth: 0, minHeight: size.minHeight(variant))
      .background(
        variant
          .backgroundAnimation(
            configuration: configuration,
            variant: variant,
            isHovering: isHovering
          )
          .primaryVariantBrightness(
            isPrimaryVariant: isPrimaryVariant,
            isPressed: isPressed,
            isHovering: isHovering
          )
      )
      .foregroundColor(
        variant.foregroundAnimation(
          configuration: configuration,
          variant: variant,
          isHovering: isHovering
        )
      )
      .cornerRadius(5)
    #if os(macOS)
      .onHover(disabled: variant == .disabled ? true : false) {
        self.isHovering = $0
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
