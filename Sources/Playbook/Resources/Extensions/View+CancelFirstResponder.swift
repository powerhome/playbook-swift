//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  View+CancelFirstResponder.swift
//

import SwiftUI

struct CancelFirstResponder: ViewModifier {
  func body(content: Content) -> some View {
    content
      .onTapGesture {
        #if os(iOS)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #elseif os(macOS)
        NSApplication.shared.sendAction(#selector(NSResponder.resignFirstResponder), to: nil, from: nil)
        #endif
        }
  }
}

public extension View {
  func cancelFirstResponder() -> some View {
    self.modifier(CancelFirstResponder())
  }
}
