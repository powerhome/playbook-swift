//
//  PopoverHandler.swift
//  
//
//  Created by Isis Silva on 09/11/23.
//

import SwiftUI

struct PopoverHandler: ViewModifier {
  @Environment(\.popoverValue) var popover

  func body(content: Content) -> some View {
    content.overlay(VStack { popover })
  }
}

public extension View {
  func withPopoverHandling(_ popover: AnyView?, position: PBToast.Position = .top) -> some View {
    self
      .modifier(PopoverHandler())
      .environment(\.popoverValue, popover)
  }
}
