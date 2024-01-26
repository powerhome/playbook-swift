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
  var popover: AnyView?

  func body(content: Content) -> some View {
    content.overlay(VStack { popover })
  }
}

public extension View {
  func withPopoverHandling(_ popover: AnyView?) -> some View {
    self.modifier(PopoverHandler(popover: popover))
  }
}
