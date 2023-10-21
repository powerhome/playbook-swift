//
//  FrameGetter+View.swift
//  
//
//  Created by Isis Silva on 17/10/23.
//

import SwiftUI

extension View {
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
        if rect.integral != self.frame.integral {
          Task {
            self.frame = rect
            print("frame \(rect)")
          }
        }
        return AnyView(EmptyView())
      })
  }
}
