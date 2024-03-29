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
  public init(
    isPresented: Bool = true,
    position: CGPoint? = nil,
    view: AnyView? = nil
  ) {
    self.isPresented = isPresented
    self.position = position
    self.view = view
  }
  var isPresented: Bool
  var position: CGPoint?
  var view: AnyView?
}
