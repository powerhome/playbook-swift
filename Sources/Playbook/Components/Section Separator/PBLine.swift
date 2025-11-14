//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBLine.swift
//

import SwiftUI

public struct PBLine: Shape {
  let orientation: Orientation

  public func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: 0, y: 0))
      if orientation == .horizontal {
          path.addLine(to: CGPoint(x: rect.width, y: 0))
      } else {
          path.addLine(to: CGPoint(x: 0, y: rect.height))
      }
    return path
  }
}
