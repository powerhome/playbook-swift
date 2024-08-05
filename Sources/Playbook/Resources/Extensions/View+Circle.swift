//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  View+Circle.swift
//

import SwiftUI

extension View {
  func circleIcon(
    icon: FontAwesome,
    iconSize: PBIcon.IconSize,
    strokeColor: Color,
    lineWidth: CGFloat, background: Color,
    circleWidth: CGFloat,
    circleHeight: CGFloat,
    iconColor: Color,
    offsetX: CGFloat?,
    offsetY: CGFloat?,
    opacity: Double?
  ) -> some View {
    Circle()
      .stroke(strokeColor, lineWidth: lineWidth)
      .background(Circle().fill(background))
      .frame(width: circleWidth, height: circleHeight)
      .overlay {
        PBIcon(icon, size: iconSize)
          .foregroundStyle(iconColor)
          .opacity(opacity ?? 1)
      }
      .offset(x: offsetX ?? 0, y: offsetY ?? 0)
      
  }
}
