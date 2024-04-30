//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBLoader.swift
//

import SwiftUI

struct PBLoader: View {
  @State private var dotIndex: Int
  @State private var isAnimating: Bool = false
  let dotsCount: Int
  let dotSize: CGFloat
  let spinnerSpeed: TimeInterval
  let isLoaderSolid: Bool
  let solidLoaderColor: Color
  let solidLoaderSize: CGFloat
  public init(
    dotIndex: Int = 0,
    dotsCount: Int = 8,
    dotSize: CGFloat = 2,
    isLoaderSolid: Bool = false,
    solidLoaderColor: Color = .text(.light),
    solidLoaderSize: CGFloat = 15,
    spinnerSpeed: TimeInterval = 0.1
  ) {
    self.dotIndex = dotIndex
    self.dotsCount = dotsCount
    self.dotSize = dotSize
    self.isLoaderSolid = isLoaderSolid
    self.solidLoaderColor = solidLoaderColor
    self.solidLoaderSize = solidLoaderSize
    self.spinnerSpeed = spinnerSpeed
  }
  var body: some View {
    if isLoaderSolid {
      solidLoaderView
    } else {
      loaderView
    }
  }
}

extension PBLoader {
  var loaderView: some View {
    CircularLayout {
      ForEach(0..<dotsCount, id: \.self) { index in
        dotView(index)
      }
    }
    .animation(
      .linear(duration: 5)
      .repeatForever(autoreverses: false),
      value: 360
    )
    .onAppear {
      Timer.scheduledTimer(
        withTimeInterval: spinnerSpeed,
        repeats: true) { _ in
          dotIndex = (dotIndex + 1) % dotsCount
        }
    }
  }
}

extension PBLoader {
  func dotView(_ index: Int) -> some View {
    Circle()
      .foregroundStyle(dotColor(index))
      .frame(width: dotSize, height: dotSize)
  }
  func dotColor(_ index: Int) -> Color {
    index == dotIndex ? Color.clear : Color.text(.light)
  }
  @ViewBuilder
  var solidLoaderView: some View {
    Circle()
      .trim(from: 0, to: 0.8)
      .stroke(Color.text(.light), lineWidth: 2)
      .rotationEffect(.degrees(isAnimating ? 360 : 0))
      .frame(width: solidLoaderSize, height: solidLoaderSize)
      .animation(
        .linear(duration: 0.8)
        .repeatForever(autoreverses: false),
        value: isAnimating
      )
      .onAppear {
        DispatchQueue.main.async {
          isAnimating = true
      }
    }
  }
}

#Preview {
  registerFonts()
  return LoaderCatalog()
}
