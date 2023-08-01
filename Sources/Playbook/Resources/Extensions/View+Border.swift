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

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct MyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
//        path.addRect(rect)
      path.addRoundedRect(in: rect, cornerSize: CGSize(width: 10, height: 10))
        return path
    }
}

struct ContentView: View {
    var body: some View {
        MyShape()
        .stroke(Color.blue, lineWidth: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
        .clipShape(Rectangle().offset(x: -30, y: 0)) // Hide the top part of the view
        .padding()
    }
}
