//
//  View+Brightness.swift
//  
//
//  Created by Gavin Huang on 4/26/23.
//

import SwiftUI

extension View {
  func primaryVariantBrightness(
    isPrimaryVariant: Bool,
    isPressed: Bool,
    isHovering: Bool
  ) -> some View {
    if isPrimaryVariant {
      #if os(macOS)
      if isPressed {
        return self.brightness(isPressed ? 0 : -0.04)
      } else if isHovering {
        return self.brightness(isHovering ? -0.04 : 0)
      } else {
        return self.brightness(0)
      }
      #else
      return self.brightness(isPressed ? 0 : -0.04)
      #endif
    } else {
      return self.brightness(0)
    }
  }
}
