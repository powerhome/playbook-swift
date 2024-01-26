//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBSpinner.swift
//

import SwiftUI

public struct PBSpinner: View {
  let innerColor: Color
  let ringColor: Color
  let ringSize: CGSize
  @State private var isAnimating: Bool = false

  public init(
    ringColor: Color = .pbPrimary,
    innerColor: Color = .card,
    ringSize: CGSize = CGSize(width: 20, height: 20)
  ) {
    self.innerColor = innerColor
    self.ringColor = ringColor
    self.ringSize = ringSize
  }

  public var body: some View {
    ZStack {
      Circle()
        .stroke(innerColor, style: StrokeStyle(lineWidth: 4))
        .frame(width: ringSize.width, height: ringSize.height)
        .background(RoundedRectangle(cornerRadius: ringSize.height).fill(Color.background(.default)))

      Circle()
        .trim(from: 0.3, to: 1)
        .stroke(
          LinearGradient(
            gradient: Gradient(colors: [.pbPrimary, .pbPrimary.opacity(0.75)]),
            startPoint: .topTrailing, endPoint: .bottomLeading
          ),
          style: StrokeStyle(lineWidth: 4, lineCap: .round)
        )
        .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
        .frame(width: ringSize.width, height: ringSize.height)
        .shadow(color: .shadow, radius: 2, x: 0, y: 2)
        .animation(
          Animation
            .linear(duration: 0.75)
            .repeatForever(autoreverses: false),
          value: isAnimating
        )
        .onAppear {
          isAnimating.toggle()
        }
    }.background(Color.clear)
  }
}

public struct PBSpinner_Previews: PreviewProvider {
  public static var previews: some View {
    PBSpinner()
  }
}
