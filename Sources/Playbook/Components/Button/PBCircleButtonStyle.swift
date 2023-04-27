//
//  PBCircleButtonStyle.swift
//
//
//  Created by Gavin Huang on 4/11/23.
//

import SwiftUI

public struct PBCircleButtonStyle: ButtonStyle {
  var variant: PBButtonVariant
  var shape: PBButtonShape
  var size: PBButtonSize
  @State private var isHovering = false

  public func makeBody(configuration: Configuration) -> some View {
    let isPressed = configuration.isPressed
    let isPrimaryVariant = variant == .primary

    configuration.label
      .frame(minWidth: 40, minHeight: 40)
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
      .clipShape(Circle())
    #if os(macOS)
      .onHover(disabled: variant == .disabled ? true : false) { self.isHovering = $0
      }
    #endif
  }
}

@available(macOS 13.0, *)
struct PBCircleStyle_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return HStack {
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
    .previewDisplayName("Circle Button Variants")
  }
}
