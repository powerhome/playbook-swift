//
//  View+Border.swift
//  
//
//  Created by Isis Silva on 14/06/23.
//

import SwiftUI

extension View {
  func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
    overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
  }
}

struct EdgeBorder: Shape {
  var width: CGFloat
  var edges: [Edge]

  func path(in rect: CGRect) -> Path {
    var path = Path()
    for edge in edges {
      var x: CGFloat {
        switch edge {
        case .top, .bottom, .leading: return rect.minX
        case .trailing: return rect.maxX - width
        }
      }

      var y: CGFloat {
        switch edge {
        case .top, .leading, .trailing: return rect.minY
        case .bottom: return rect.maxY - width
        }
      }

      var w: CGFloat {
        switch edge {
        case .top, .bottom: return rect.width
        case .leading, .trailing: return width
        }
      }

      var h: CGFloat {
        switch edge {
        case .top, .bottom: return width
        case .leading, .trailing: return rect.height
        }
      }
      path.addRect(CGRect(x: x, y: y, width: w, height: h))
    }
    return path
  }
}

struct TabBarShape: Shape {
  let tabHeight: Double

  func path(in rect: CGRect) -> Path {
    var path = Path()
    let radius: Double = 20
    let height: Double = Double(100)
    let origen = CGPoint(x: rect.minX, y: rect.maxY)
    let arcCenterY = origen.y - radius

    let arcCenter1 = CGPoint(
      x: origen.x + radius,
      y: arcCenterY
    )

    let arcCenter2 = CGPoint(
      x: rect.maxX - radius,
      y: arcCenterY
    )
    
    let arcCenter3 = CGPoint(
      x: rect.maxX - radius,
      y: height - radius
    )

    let arcCenter4 = CGPoint(
      x: origen.x + radius,
      y: height - radius
    )

    path.move(to: origen)

    path.addArc(
      center: arcCenter1,
      radius: radius,
      startAngle: .degrees(180),
      endAngle: .degrees(-90),
      clockwise: false
    )

    path.addLine(to: CGPoint(x: rect.maxX - radius, y: arcCenterY - radius))

    path.addArc(
      center: arcCenter2,
      radius: radius,
      startAngle: .degrees(-90),
      endAngle: .degrees(0),
      clockwise: false
    )
    
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY + height))

//    path.addArc(
//      center: arcCenter3,
//      radius: radius,
//      startAngle: .degrees(-90),
//      endAngle: .degrees(0),
//      clockwise: false
//    )

    return path
  }
}

struct ToolBarShape_Previews: PreviewProvider {
  static var previews: some View {
    TabBarShape(tabHeight: 40)
      .stroke(lineWidth: 2)
      .foregroundColor(.pink)
      .padding(.bottom, 200)
    
  }
}
