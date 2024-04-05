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
  let alignment: Alignment
  let top: CGFloat?
  let leading: CGFloat?
  let bottom: CGFloat?
  let trailing: CGFloat?
  @Binding var contentSize: CGSize
  var overlay: () -> T
  public init(
    alignment: Alignment = .leading,
    contentSize: Binding<CGSize> = .constant(.zero),
    top: CGFloat? = 0,
    leading: CGFloat? = 0,
    bottom: CGFloat? = 0,
    trailing: CGFloat? = 0,
    overlay: @escaping () -> T
  ) {
    self.alignment = alignment
    _contentSize = contentSize
    self.top = top
    self.leading = leading
    self.bottom = bottom
    self.trailing = trailing
    self.overlay = overlay
  }
  
  
  public func body(content: Content) -> some View {
    content
      .overlay(alignment: alignment) {
        if #available(iOS 17.0, *) {
          overlay()
            .scaledToFill()
            .edgeInsets(EdgeInsets(top: top ?? 0, leading: leading ?? 0, bottom: bottom ?? 0, trailing: trailing ?? 0))
            .visualEffect { content, geo in
              content
                .offset(x: geo.size.width / 4, y: geo.size.height / 4)
            }
        } else {
          // Fallback on earlier versions
        }
      }
     
  }
}

struct EdgeInsetModifier: ViewModifier {
  let insets: EdgeInsets
  
  func body(content: Content) -> some View {
    content
      .padding(insets)
  }
}

extension View {
  func globalPosition<T: View>(overlay: @escaping (() -> T), alignment: Alignment, top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> some View {
    self.modifier(GlobalPosition(alignment: alignment, top: top, leading: leading, bottom: bottom, trailing: trailing, overlay: overlay))
  }
  func edgeInsets(_ insets: EdgeInsets) -> some View {
    self.modifier(EdgeInsetModifier(insets: insets))
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
