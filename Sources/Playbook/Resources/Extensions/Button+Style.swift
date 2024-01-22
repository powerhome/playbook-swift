//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Button+Style.swift
//

import SwiftUI

extension Button {
  @ViewBuilder
  func customButtonStyle(
    variant: PBButton.Variant,
    shape: PBButton.Shape,
    size: PBButton.Size
  ) -> some View {
    switch shape {
    case .primary:
      self.buttonStyle(
        PBButtonStyle(
          variant: variant,
          size: size
        )
      )
    case .circle:
      self.buttonStyle(
        PBCircleButtonStyle(
          variant: variant,
          size: size
        )
      )
    }
  }
}
