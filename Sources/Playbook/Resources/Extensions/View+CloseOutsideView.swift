//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  View+CloseOutsideView.swift
//

import Foundation
import SwiftUI

struct ClickOutsideToClose: ViewModifier {
  let isOpen: Bool
  let close: () -> Void

  func body(content: Content) -> some View {
    ZStack {
      content
        .zIndex(1)
    }
    .background(
      Group {
        if isOpen {
          Color.clear
            .contentShape(Rectangle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
              close()
            }
            .ignoresSafeArea()
        }
      }
      .frame(minWidth: 1000, minHeight: 1000)
    )
  }
}

extension View {
  func clickOutsideToClose(isOpen: Bool, close: @escaping () -> Void) -> some View {
    self.modifier(ClickOutsideToClose(isOpen: isOpen, close: close))
  }
}
