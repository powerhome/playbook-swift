//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  CircularLayout.swift
//

import SwiftUI

struct CircularLayout: Layout {
  func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
    var width: CGFloat = .zero
    var height: CGFloat = .zero
    for subview in subviews {
      width += subview.sizeThatFits(proposal).width
      height += subview.sizeThatFits(proposal).height
    }
    return CGSize(width: width, height: height)
  }
  
  func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
    let radius = min(bounds.size.width, bounds.size.height) / 2
    let angle = Angle.degrees(360 / Double(subviews.count)).radians
    for (index, subview) in subviews.enumerated() {
      let viewSize = subview.sizeThatFits(.unspecified)
      let xPos = cos(angle * Double(index) - .pi / 2) * (radius - viewSize.width / 2)
      let yPos = sin(angle * Double(index) - .pi / 2) * (radius - viewSize.height / 2)
      let point = CGPoint(x: bounds.midX + xPos, y: bounds.midY + yPos)
      subview.place(at: point, anchor: .center, proposal: .unspecified)
    }
  }
}
