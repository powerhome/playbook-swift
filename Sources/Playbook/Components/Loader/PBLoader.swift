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
  let dotsCount: Int
  let dotSize: CGFloat
  let spinnerSpeed: TimeInterval
  let isLoaderSolid: Bool
  let solidLoaderColor: Color
  @State private var isAnimating: Bool = false
  public init(
    dotIndex: Int = 0,
    dotsCount: Int = 8,
    dotSize: CGFloat = 2,
    isLoaderSolid: Bool = false,
    solidLoaderColor: Color = .text(.light),
    spinnerSpeed: TimeInterval = 0.1
  ) {
    self.dotIndex = dotIndex
    self.dotsCount = dotsCount
    self.dotSize = dotSize
    self.isLoaderSolid = isLoaderSolid
    self.solidLoaderColor = solidLoaderColor
    self.spinnerSpeed = spinnerSpeed
  }
  var body: some View {
    loaderView
  }
}

extension PBLoader {
  var loaderView: some View {
   
    CircularLayout {
      if isLoaderSolid {
        solidLoader
        
      } else {
        ForEach(0..<dotsCount, id: \.self) { index in
          dotView(index)
          
        }
      }
    }
    .animation(
      .linear(duration: 5)
      .repeatForever(autoreverses: false),
      value: 360
    )
    .onAppear {
      isAnimating.toggle()
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
  var solidLoader: some View {
    VStack {
      Circle()
        .trim(from: 0.2, to: 1)
        .stroke(
          LinearGradient(
            gradient: Gradient(colors: [solidLoaderColor, solidLoaderColor]),
            startPoint: .topTrailing, endPoint: .bottomLeading
          ),
          style: StrokeStyle(lineWidth: 2, lineCap: .round)
        )
        .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
        .frame(width: dotSize, height: dotSize)
        .animation(
          .linear(duration: 0.8)
          .repeatForever(autoreverses: false),
          value: isAnimating
        )
    }
  }
}

#Preview {
  registerFonts()
  return LoaderCatalog()
}
