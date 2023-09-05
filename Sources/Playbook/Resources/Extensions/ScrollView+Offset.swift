//
//  ScrollView+Offset.swift
//  
//
//  Created by Isis Silva on 05/09/23.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGPoint = .zero
  static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
  }
}

// struct OffsetScrollView<Content: View>: View {
//  let content: Content
//  @Binding var scrollPosition: CGPoint
//  
//  init(content: View, scrollPosition: CGPoint) {
//    self.content = content
//    self._scrollPosition = scrollPosition
//  }
//  
//  var body: some View {
//    ScrollView {
//      content
//      .padding(Spacing.medium)
//      .background(GeometryReader { geometry in
//        Color.clear
//          .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
//      })
//      .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
//        self.scrollPosition = value
//        print("Scroll offset: \(scrollPosition.y)")
//      }
//    }
//    .coordinateSpace(name: "scroll")
//  }
// }
