//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  View+Position.swift
//

import SwiftUI

extension View {
  func positioning(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> some View{
    self.modifier(Position(top: top, left: left, right: right, bottom: bottom))
  }
}
