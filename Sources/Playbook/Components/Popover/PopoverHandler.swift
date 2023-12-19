//
//  PopoverHandler.swift
//  
//
//  Created by Isis Silva on 09/11/23.
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
