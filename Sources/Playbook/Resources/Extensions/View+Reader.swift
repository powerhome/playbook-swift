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
  func coordinateSpace(in geometry: GeometryProxy) -> CGRect {
    if #available(iOS 17.0, *), #available(macOS 14.0, *) {
      return geometry.frame(in: .scrollView)
    } else {
      return geometry.frame(in: .global)
    }
  }

  func frameReader(in rect: @escaping (CGRect) -> Void) -> some View {
      return background(
        GeometryReader { geometry in
            Color.clear
                .onChange(of: coordinateSpace(in: geometry)) { _, space in rect(space) }
                .onAppear {
                    rect(coordinateSpace(in: geometry))
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
          .onChange(of: transaction?.animation) {
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
