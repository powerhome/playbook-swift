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
  var overlay: () -> T
  let alignment: Alignment
//  @State private var contentSize: CGSize = .zero
  @Binding var contentSize: CGSize
  public init(
    overlay: @escaping () -> T,
    alignment: Alignment = .leading,
    contentSize: Binding<CGSize> = .constant(.zero)
  ) {
    self.overlay = overlay
    self.alignment = alignment
    _contentSize = contentSize
  }
  
  
  public func body(content: Content) -> some View {
    ZStack(alignment: alignment) {
      content
          .background(
          GeometryReader { geometry in
            Color.clear
              .onAppear {
                contentSize = geometry.size
              }
          }
          )
      overlay()
      
    }
  }
}

extension View {
  func globalPosition<T: View>(overlay: @escaping (() -> T), alignment: Alignment) -> some View {
    self.modifier(GlobalPosition(overlay: overlay, alignment: alignment))
  }
}


/*** Isis

public struct GlobalPositionS<T: View>: ViewModifier {
//  var top: CGFloat
//  var left: CGFloat
//  var right: CGFloat
//  var bottom: CGFloat
//  var spacing: CGFloat?
  var view: () -> T
  
  var position: Position = .bottomTrailing
  
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
            view()
              .position(position.circlePosition(with: frame))
              
          }
        } 
   }
}


extension GlobalPosition {
  enum ContentShape {
    case rect, circle
  }
}
  
enum Position: String, CaseIterable, Identifiable {
  var id: UUID { UUID() }
    case topLeading
    case top
    case topTrailing
    case trailing
    case bottomTrailing
    case bottom
    case bottomLeading
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
      case .bottomTrailing:
        return CGPoint(
          x: radius * sin(Angle(degrees: 45).degrees) + center.x,
          y: radius * cos(Angle(degrees: 45).degrees) + center.y
        )
      case .bottom:
        return CGPoint(
          x: center.x,
          y: radius * 2
        )
      case .bottomLeading:
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
  func globalPositionS<T: View>(
    position: Position,
    view: @escaping (() -> T)
  ) -> some View{
    self.modifier(
      GlobalPositionS(
        view: view,
        position: position
      
      )
    )
  }
}

*/

#Preview {
  registerFonts()
  return GlobalPositionCatalog()
 
}
