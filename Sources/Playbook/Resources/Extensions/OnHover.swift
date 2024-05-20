//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  OnHover.swift
//

import SwiftUI

extension View {
  @inlinable
  func onHover(disabled: Bool, action: @escaping (Bool) -> Void) -> some View {
    return AnyView(
      self.onHover { hovering in
        action(hovering)
        #if os(macOS)
          switch (hovering, disabled) {
          case (true, false): NSCursor.pointingHand.set()
          case (true, true): NSCursor.operationNotAllowed.set()
          default: NSCursor.arrow.set()
          }
        #endif
      }
    )
  }
}
