//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverHandler.swift
//

import SwiftUI

struct PopoverHandler: ViewModifier {
  var popoverManager: PopoverManager

  func body(content: Content) -> some View {
    content.overlay(
      Group {
        if popoverManager.isPresented {
          popoverManager.view
            .position(popoverManager.position ?? .zero)
        }
      }
    )
  }
}

public extension View {
  func withPopoverHandling(_ manager: PopoverManager) -> some View {
    self.modifier(PopoverHandler(popoverManager: manager))
  }
}

@Observable
public final class PopoverManager {
  var isPresented: Bool = false
  var position: CGPoint?
  var view: AnyView?
}
