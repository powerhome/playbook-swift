//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  SwiftUIView.swift
//

import SwiftUI

extension View {
  #if os(macOS)
  static func disableAnimation() {
    NSAnimationContext.runAnimationGroup({ context in
      context.duration = 0
    }, completionHandler:nil)
  }
  #elseif os(iOS)
  static func disableAnimation() {
    UIView.setAnimationsEnabled(false)
  }
  #endif
}
