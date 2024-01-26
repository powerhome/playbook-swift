//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  FrameGetter+View.swift
//

import SwiftUI

public extension View {
  func frameGetter(_ frame: Binding<CGRect>) -> some View {
    modifier(FrameGetter(frame: frame))
  }
}

struct FrameGetter: ViewModifier {
  @Binding var frame: CGRect

  func body(content: Content) -> some View {
    content
      .background(GeometryReader { proxy -> AnyView in
        let rect = proxy.frame(in: .global)
        if rect.integral != frame.integral {
          Task {
            frame = rect
          }
        }
        return AnyView(EmptyView())
      })
  }
}
