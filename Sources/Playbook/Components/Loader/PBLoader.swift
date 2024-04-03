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
  @State private var rotationAngle: Double
  @State private var dotIndex: Int
  @State private var contentSize: CGSize
  let dotsCount: Int
  let dotSize: CGFloat
  let circleRadius: CGFloat
  let spinnerFont: PBFont
  let spinnerSpeed: TimeInterval
  let alignment: HorizontalAlignment
  public init(
    rotationAngle: Double = 0,
    dotIndex: Int = 0,
    contentSize: CGSize = .zero,
    dotsCount: Int = 7,
    dotSize: CGFloat = 2,
    circleRadius: CGFloat = 7,
    spinnerFont: PBFont = .body,
    spinnerSpeed: TimeInterval = 0.1,
    alignment: HorizontalAlignment = .center
  ) {
    self.rotationAngle = rotationAngle
    self.dotIndex = dotIndex
    self.contentSize = contentSize
    self.dotsCount = dotsCount
    self.dotSize = dotSize
    self.circleRadius = circleRadius
    self.spinnerFont = spinnerFont
    self.spinnerSpeed = spinnerSpeed
    self.alignment = alignment
  }
  var body: some View {
    loaderView
  }
}

extension PBLoader {
  var loaderView: some View {
    GeometryReader { geo in
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
          contentSize = geo.size
        }
      }
    }
    .frame(maxWidth: contentSize.width)
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
