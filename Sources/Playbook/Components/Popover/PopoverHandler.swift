//
//  PopoverHandler.swift
//  
//
//  Created by Isis Silva on 09/11/23.
//

import SwiftUI

struct PopoverHandler: ViewModifier {
  @Environment(\.popoverValue) var popover
  @Binding var isPresented: Bool

  func body(content: Content) -> some View {
    if isPresented {
      content.overlay(VStack { popover })
    } else {
      content
    }
  }
}

public extension View {
  func withPopoverHandling(isPresented: Binding<Bool>, _ popover: AnyView?, position: PBToast.Position = .top) -> some View {
    self
      .modifier(PopoverHandler(isPresented: isPresented))
      .environment(\.popoverValue, popover)
  }
}
