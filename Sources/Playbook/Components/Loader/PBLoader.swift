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
  var rotationAngle: Double
  var contentSize: CGSize
  let dotsCount: Int
  let dotSize: CGFloat
  let circleRadius: CGFloat
  let spinnerSpeed: TimeInterval
  public init(
    rotationAngle: Double = 0,
    dotIndex: Int = 0,
    contentSize: CGSize = .zero,
    dotsCount: Int = 8,
    dotSize: CGFloat = 2,
    circleRadius: CGFloat = 7,
    spinnerSpeed: TimeInterval = 0.1
  ) {
    self.rotationAngle = rotationAngle
    self.dotIndex = dotIndex
    self.contentSize = contentSize
    self.dotsCount = dotsCount
    self.dotSize = dotSize
    self.circleRadius = circleRadius
    self.spinnerSpeed = spinnerSpeed
  }
  var body: some View {
        loaderView
  }
}

extension PBLoader {
  var loaderView: some View {
      ZStack {
        ForEach(0..<dotsCount, id: \.self) { index in
          Circle()
            .pbFont(.body, color: index == dotIndex ? Color.clear : Color.text(.light))
            .frame(width: dotSize, height: dotSize)
            .offset(circleOffset(for: index, in: contentSize))
            .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: rotationAngle)
         
        }
      }
      .onAppear {
        Timer.scheduledTimer(withTimeInterval: spinnerSpeed, repeats: true) { _ in
          dotIndex = (dotIndex + 1) % dotsCount
        }
      }
  }
  func circleOffset(for index: Int, in size: CGSize) -> CGSize {
    let currentAngle = rotationAngle + 2 * .pi / Double(dotsCount) * Double(index)
    let centerX = size.width / 2
    let centerY = size.height / 2
    let x = centerX + circleRadius * cos(currentAngle)
    let y = centerY + circleRadius * sin(currentAngle)
    return CGSize(width: x, height: y)
  }
}

#Preview {
  registerFonts()
  return LoaderCatalog()
}
