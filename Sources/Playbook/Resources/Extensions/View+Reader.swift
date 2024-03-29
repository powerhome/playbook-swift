//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  View+Reader.swift
//

import SwiftUI

public extension View {
  func frameReader(in coordinateSpace: CoordinateSpace = .global, rect: @escaping (CGRect) -> Void) -> some View {
    return background(
      GeometryReader { geometry in
        let frame = geometry.frame(in: coordinateSpace)
        Color.clear
          .onChange(of: frame) { _, newValue in
            rect(newValue)
          }
          .onAppear {
            rect(frame)
          }
      }
        .hidden()
    )
  }
  
  func sizeReader(transaction: Transaction? = nil, size: @escaping (CGSize) -> Void) -> some View {
    return background(
      GeometryReader { geometry in
        Color.clear
          .preference(key: ContentSizeReaderPreferenceKey.self, value: geometry.size)
          .onPreferenceChange(ContentSizeReaderPreferenceKey.self) { newValue in
            DispatchQueue.main.async {
              size(newValue)
            }
          }
          .onChange(of: transaction?.animation) { _, _ in
            DispatchQueue.main.async {
              size(geometry.size)
            }
          }
      }
        .hidden()
    )
  }
}

struct ContentFrameReaderPreferenceKey: PreferenceKey {
  static var defaultValue: CGRect { return CGRect() }
  static func reduce(value: inout CGRect, nextValue: () -> CGRect) { value = nextValue() }
}

struct ContentSizeReaderPreferenceKey: PreferenceKey {
  static var defaultValue: CGSize { return CGSize() }
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) { value = nextValue() }
}
