//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Position.swift
//

import Foundation
import SwiftUI


public struct Position: ViewModifier {
    var top: CGFloat = 0
    var left: CGFloat = 0
    var right: CGFloat = 0
    var bottom: CGFloat = 0
  
  public init(
    top: CGFloat = 0,
    left: CGFloat = 0,
    right: CGFloat = 0,
    bottom: CGFloat = 0
  ){
    self.top = top
    self.left = left
    self.right = right
    self.bottom = bottom
  }
  
  public func body(content: Content) -> some View {
    content
      .offset(x: left - right, y: top - bottom)
  }
}
