//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  GlobalPosition.swift
//

import SwiftUI

public struct GlobalPosition<T: View>: ViewModifier {
//  var top: CGFloat
//  var left: CGFloat
//  var right: CGFloat
//  var bottom: CGFloat
//  var spacing: CGFloat?
  var view: () -> T
  
  var position: Positiona = .bottonTrailing
  
//  var shape: Shape = Circle
  
//  public init(
//    top: CGFloat = 0,
//    left: CGFloat = 0,
//    right: CGFloat = 0,
//    bottom: CGFloat = 0,
//    spacing: CGFloat? = 0,
//    view: @escaping () -> T
//  ){
//    self.top = top
//    self.left = left
//    self.right = right
//    self.bottom = bottom
//    self.spacing = spacing
//    self.view = view
//  }
  
  public func body(content: Content) -> some View {
      content
        .overlay {
          GeometryReader { geometry in
            let frame = geometry.frame(in: .local)
            view().position(position.circlePosition(with: frame))
          }
        } 
   }
}

extension GlobalPosition {
  enum ContentShape {
    case rect, circle
  }
}
  
enum Positiona: String, CaseIterable, Identifiable {
  var id: UUID { UUID() }
    case topLeading
    case top
    case topTrailing
    case trailing
    case bottonTrailing
    case botton
    case bottonLeading
    case leading

    func circlePosition(with frame: CGRect) -> CGPoint {
      let center = CGPoint(x: frame.width/2, y: frame.height/2)
      let radius = frame.width/2
      
      switch self {
      case .topLeading:
        return CGPoint(
          x: center.x - radius * cos(-45),
          y: center.y - radius * sin(Angle(degrees: 45).degrees)
        )
      case .top:
        return CGPoint(
          x: center.x,
          y: 0
        )
      case .topTrailing:
        return CGPoint(
          x: radius * cos(Angle(degrees: 60).degrees) + center.x,
          y: radius * cos(Angle(degrees: 60).degrees) + center.y
        )
      case .trailing:
        return CGPoint(
          x: radius * 2,
          y: center.y
        )
      case .bottonTrailing:
        return CGPoint(
          x: radius * sin(Angle(degrees: 45).degrees) + center.x,
          y: radius * cos(Angle(degrees: 45).degrees) + center.y
        )
      case .botton:
        return CGPoint(
          x: center.x,
          y: radius * 2
        )
      case .bottonLeading:
        return CGPoint(
          x: radius * sin(Angle(degrees: 45).degrees) + center.x,
          y: radius * cos(Angle(degrees: 45).degrees) + center.y
        )
      case .leading:
        return CGPoint(
          x: 0,
          y: center.y
        )
      }
    }
}

extension View {
  func globalPosition<T: View>(
    position: Positiona,
    view: @escaping (() -> T)
  ) -> some View{
    self.modifier(
      GlobalPosition(
        view: view, 
        position: position
      
      )
    )
  }
}

#Preview {
  registerFonts()
  return GlobalPositionCatalog()
}
