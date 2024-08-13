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
    icon: PBIcon?,
    borderColor: Color,
    borderWidth: CGFloat,
    backgroundColor: Color,
    diameter: CGFloat,
    offsetX: CGFloat? = nil,
    offsetY: CGFloat? = nil,
    opacity: Double?
  ) -> some View {
    Circle()
      .stroke(borderColor, lineWidth: borderWidth)
      .background(Circle().fill(backgroundColor))
      .frame(width: diameter)
      .overlay {
        if let icon = icon {
          PBIcon(icon.icon, size: icon.size, color: icon.color)
            .opacity(opacity ?? 1)
        }
      }
      .offset(x: offsetX ?? 0, y: offsetY ?? 0)
  }
}

