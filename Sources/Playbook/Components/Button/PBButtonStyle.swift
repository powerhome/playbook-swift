//
//  PBButtonStyle.swift
//
//
//  Created by Gavin Huang on 4/11/23.
//

import SwiftUI

public struct PBButtonStyle: ButtonStyle {
  var variant: PBButton.Variant
  var size: PBButton.Size
  @State private var isHovering = false

  public init(
    variant: PBButton.Variant,
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
