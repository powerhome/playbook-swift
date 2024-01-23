//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  View+Border.swift
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
