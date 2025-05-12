//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  SkeletonLoader.swift
//

import Foundation
import SwiftUI

public struct SkeletonModifier: ViewModifier {
  @Binding var isLoading: Bool
  let animation: Animation
  let cornerRadius: CGFloat
  let shape: SkeletonShape
  @State private var opacity: Double = 0.3
  @State private var startPoint: UnitPoint = UnitPoint(x: -1, y: 0.5)
  @State private var endPoint: UnitPoint = UnitPoint(x: 0, y: 0.5)

  public func body(content: Content) -> some View {
    if isLoading {
      content
        .hidden()
        .overlay {
          shape.skeletonShape
            .foregroundStyle(
              LinearGradient(
                gradient: Gradient(colors: [
                  Color(hex: "#f3f7fb"),
                  Color(hex: "#f3f7fb"),
                  Color(hex: "#eef4f9")
                ]),
                startPoint: startPoint,
                endPoint: endPoint
              )
            )
        }
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            isLoading = true

            withAnimation(animation.repeatForever(autoreverses: false)) {
              startPoint = UnitPoint(x: 1, y: 0.5)
              endPoint = UnitPoint(x: 2, y: 0.5)
            }
          }
        }
    } else {
      content
    }
  }
}

public extension View {
  func skeletonLoader(
    isLoading: Binding<Bool>,
    animation: Animation = .smooth(duration: 1.0),
    cornerRadius: CGFloat = 8,
    shape: SkeletonShape
  ) -> some View {
    modifier(SkeletonModifier(
      isLoading: isLoading,
      animation: animation,
      cornerRadius: cornerRadius,
      shape: shape
    ))
  }
}
