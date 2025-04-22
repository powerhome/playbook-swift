//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBSkeletonLoader.swift
//

import SwiftUI

public struct PBSkeletonLoader<Content: View>: View {
  @Binding var isLoading: Bool
  let animation: Animation
  let shape: SkeletonShape
  let content: Content
  var alignment: Alignment
  @State private var startPoint: UnitPoint = UnitPoint(x: -1, y: 0.5)
  @State private var endPoint: UnitPoint = UnitPoint(x: 0, y: 0.5)

  public init(
    isLoading: Binding<Bool> = .constant(false),
    animation: Animation = .smooth(duration: 1.0),
    shape: SkeletonShape = .rectangle(),
    alignment: Alignment = .leading,
    @ViewBuilder content: () -> Content
  ) {
    self._isLoading = isLoading
    self.animation = animation
    self.shape = shape
    self.alignment = alignment
    self.content = content()
  }

  public var body: some View {

    skeletonLoadingView

  }
}

public extension PBSkeletonLoader {
  enum SkeletonShape {
    case rectangle(cornerRadius: CGFloat = 8)
    case circle
    case capsule
    case custom(AnyShape)
  }

  @ViewBuilder
  var skeletonShape: some View {
    switch shape {
    case .rectangle(let cornerRadius):
      RoundedRectangle(cornerRadius: cornerRadius)
    case .circle:
      Circle()
    case .capsule:
      Capsule()
    case .custom(let shape):
      shape
    }
  }

  var skeletonLoadingView: some View {
    VStack {
      if isLoading {
        content
          .hidden()
          .overlay {
            skeletonShapeView
          }
      } else {
        content
      }
    }
    .frame(maxWidth: .infinity, alignment: alignment)
  }

  var skeletonShapeView: some View {
    skeletonShape
      .foregroundStyle(
        LinearGradient(
          gradient: Gradient(colors: [
            Color(hex: "#f3f7fb"),
            Color(hex: "#f3f7fb"),
            Color(hex: "#eef4f9"),
          ]),
          startPoint: startPoint,
          endPoint: endPoint
        )
      )
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
          isLoading = true

          withAnimation(animation.repeatForever(autoreverses: false)) {
            startPoint = UnitPoint(x: 1, y: 0.5)
            endPoint = UnitPoint(x: 2, y: 0.5)
          }
        }
      }
  }
}
