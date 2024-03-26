//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Position.swift
//

import SwiftUI

public struct Position<T: View>: ViewModifier {
  var top: CGFloat
  var left: CGFloat
  var right: CGFloat
  var bottom: CGFloat
  var spacing: CGFloat?
  var view: () -> T
  
  public init(
    top: CGFloat = 0,
    left: CGFloat = 0,
    right: CGFloat = 0,
    bottom: CGFloat = 0,
    spacing: CGFloat? = 0,
    view: @escaping () -> T
  ){
    self.top = top
    self.left = left
    self.right = right
    self.bottom = bottom
    self.spacing = spacing
    self.view = view
  }
  
  public func body(content: Content) -> some View {
    content
      .overlay {
        view()
          .position(x: left - right, y: top - bottom)
      }
   }
 }

extension View {
  func position<T: View>(
    top: CGFloat = 0,
    left: CGFloat = 0,
    bottom: CGFloat = 0,
    right: CGFloat = 0,
    view: @escaping (() -> T)
  ) -> some View{
    self.modifier(
      Position(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
        view: view
      )
    )
  }
}

#Preview {
  registerFonts()
  return PositionCatalog()
}
