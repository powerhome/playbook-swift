//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  View+CloseOutsideView.swift
//

import SwiftUI

public struct ClickOutsideToClose: ViewModifier {
  let isOpen: Bool
  let close: () -> Void

 public func body(content: Content) -> some View {
    ZStack {
      content
    }
    .background(
      Group {
        if isOpen {
          Color.clear
            .contentShape(Rectangle())
            .onTapGesture {
              close()
            }
            .ignoresSafeArea()
        }
      }
      #if os(iOS)
        .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
      #elseif os(macOS)
        .frame(minWidth: NSScreen.main?.frame.width, minHeight: NSScreen.main?.frame.height)
      #endif
    )
  }
}


public extension View {
  func clickOutsideToClose(isOpen: Bool, close: @escaping () -> Void) -> some View {
    self.modifier(ClickOutsideToClose(isOpen: isOpen, close: close))
  }

}
