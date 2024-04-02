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
  @State private var contentSize: CGSize = .zero
  let dotsCount: Int
  let dotSize: CGFloat
  let circleRadius: CGFloat
  let spinnerFont: PBFont
  let spinnerSpeed: TimeInterval
  let spinnerLabel: String
  let alignment: HorizontalAlignment
  public init(
    rotationAngle: Double = 0,
    dotIndex: Int = 0,
    dotsCount: Int = 7,
    dotSize: CGFloat = 2,
    circleRadius: CGFloat = 7,
    spinnerFont: PBFont = .body,
    spinnerSpeed: TimeInterval = 0.1,
    spinnerLabel: String = "Loading",
    alignment: HorizontalAlignment = .center
  ) {
    self.rotationAngle = rotationAngle
    self.dotIndex = dotIndex
    self.dotsCount = dotsCount
    self.dotSize = dotSize
    self.circleRadius = circleRadius
    self.spinnerFont = spinnerFont
    self.spinnerSpeed = spinnerSpeed
    self.spinnerLabel = spinnerLabel
    self.alignment = alignment
  }
  var body: some View {
    loaderLabelView
  }
}

extension PBLoader {
  var loaderLabelView: some View {
    HStack(spacing: Spacing.small) {
      loaderView
      loaderLabel
    }.pbFont(spinnerFont, color: .text(.light))
  }
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
      .frame(width: contentSize.width)
      .onAppear {
        Timer.scheduledTimer(withTimeInterval: spinnerSpeed, repeats: true) { _ in
          dotIndex = (dotIndex + 1) % dotsCount
          contentSize = geo.size
        }
      }
    }.frame(maxWidth: contentSize.width)
  }
  var loaderLabel: some View {
    Text(spinnerLabel)
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
