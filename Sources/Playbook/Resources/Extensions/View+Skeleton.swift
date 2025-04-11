//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  View+Skeleton.swift
//

import SwiftUI

public struct SkeletonModifier: ViewModifier {
  let isLoading: Bool
  let animation: Animation
  let cornerRadius: CGFloat

  @State private var opacity: Double = 0.3

  public func body(content: Content) -> some View {
    if isLoading {
      content
        .opacity(0)
        .overlay(
          RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color(hex: "#F3F7FB"))
            .onAppear {
              withAnimation(animation) {
                opacity = 0.7
              }
            }
        )
    } else {
      content
    }
  }
}

public extension View {
  func skeletonLoader(
    isLoading: Bool,
    animation: Animation = .easeInOut(duration: 1.5),
    cornerRadius: CGFloat = 8

  ) -> some View {
    modifier(SkeletonModifier(
      isLoading: isLoading,
      animation: animation,
      cornerRadius: cornerRadius
    ))
  }
}
