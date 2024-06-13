//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBButtonStyle.swift
//

import SwiftUI

public struct PBButtonStyle: ButtonStyle {
  var variant: PBButton.Variant
  var size: PBButton.Size
  @State private var isHovering = false
  @Environment(\.colorScheme) var colorScheme
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
          .background(colorScheme == .dark && variant == .secondary ? Color(NSColor(red:77, green: 73, blue: 93, alpha: 0.3)) : variant.backgroundColor)
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
