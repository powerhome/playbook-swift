//
//  ScrollView+Offset.swift
//  
//
//  Created by Isis Silva on 05/09/23.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGPoint = .zero
  static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

struct OffsetScrollView<Content: View>: View {
  let content: Content
  let scrollOffset: ((CGPoint) -> Void)

  init(
    scrollOffset: @escaping ((CGPoint) -> Void),
    @ViewBuilder content: (() -> Content)
  ) {
    self.scrollOffset = scrollOffset
    self.content = content()
  }

  var body: some View {
    ScrollView {
      content
        .background(GeometryReader { geometry in
          Color.clear
            .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
        })
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
          scrollOffset(value)
        }
    }
    .coordinateSpace(name: "scroll")
  }
}

private struct FramePreferenceKey: PreferenceKey {
    static let defaultValue = CGRect.zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

public extension View {
  func onGlobalFrameChange(_ onChange: @escaping (CGRect) -> Void) -> some View {
    background(GeometryReader { geometry in
      Color.clear.preference(key: FramePreferenceKey.self, value: geometry.frame(in: .global))
    })
    .onPreferenceChange(FramePreferenceKey.self, perform: onChange)
  }

  func print(_ varargs: Any...) -> Self {
    Swift.print(varargs)
    return self
  }
}
