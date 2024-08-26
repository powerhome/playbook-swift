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
    iconColor: Color,
    borderColor: Color,
    borderWidth: CGFloat,
    backgroundColor: Color,
    diameter: CGFloat,
    opacity: Double?
  ) -> some View {
    Circle()
      .stroke(borderColor, lineWidth: borderWidth)
      .background(Circle().fill(backgroundColor))
      .frame(width: diameter)
      .overlay {
        if let icon = icon {
          PBIcon(icon.icon, size: icon.size)
            .foregroundStyle(iconColor)
            .opacity(opacity ?? 1)
        }
      }
  }
}

