//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Popover+Position.swift
//

import SwiftUI

public enum Position {
  case absolute(originAnchor: Anchor, popoverAnchor: Anchor)

  public enum Anchor {
    case topLeft
    case top
    case topRight
    case right
    case bottomRight
    case bottom
    case bottomLeft
    case left
    case center
  }
}

public extension Position {
  func calculateFrame(from originFrame: CGRect?, size: CGSize?) -> CGRect {
    switch self {
    case let .absolute(originAnchor, popoverAnchor):
      var popoverFrame = self.absoluteFrame(
        originAnchor: originAnchor,
        popoverAnchor: popoverAnchor,
        originFrame: originFrame ?? .zero,
        popoverSize: size ?? .zero
      )
      let screenEdgePadding = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
      let safeWindowFrame = Screen.rect
    
      let maxX = safeWindowFrame.maxX - screenEdgePadding.trailing
      let maxY = safeWindowFrame.maxY - screenEdgePadding.bottom
      
      if popoverFrame.origin.x < screenEdgePadding.leading {
        popoverFrame.origin.x = screenEdgePadding.leading
      }
      if popoverFrame.origin.y < screenEdgePadding.top {
        popoverFrame.origin.y = screenEdgePadding.top
      }
      if popoverFrame.maxX > maxX {
        let difference = popoverFrame.maxX - maxX
        popoverFrame.origin.x -= difference
      }
      if popoverFrame.maxY > maxY {
        let difference = popoverFrame.maxY - maxY
        popoverFrame.origin.y -= difference
      }
      return popoverFrame
    }
  }
  
  private func absoluteFrame(
    originAnchor: Anchor,
    popoverAnchor: Anchor,
    originFrame: CGRect,
    popoverSize: CGSize
  ) -> CGRect {
    let popoverOrigin = originFrame.point(at: originAnchor)
    switch popoverAnchor {
    case .topLeft:
      return CGRect(
        origin: popoverOrigin,
        size: popoverSize
      )
    case .top:
      return CGRect(
        origin: CGPoint(x: popoverOrigin.x - popoverSize.width / 2, y: popoverOrigin.y - 0),
        size: popoverSize
      )
    case .topRight:
      return CGRect(
        origin: CGPoint(x: popoverOrigin.x - popoverSize.width, y: popoverOrigin.y - 0),
        size: popoverSize
      )
    case .right:
      return CGRect(
        origin: CGPoint(x: popoverOrigin.x - popoverSize.width, y: popoverOrigin.y - popoverSize.height / 2),
        size: popoverSize
      )
    case .bottomRight:
      return CGRect(
        origin: CGPoint(x: popoverOrigin.x - popoverSize.width, y: popoverOrigin.y - popoverSize.height),
        size: popoverSize
      )
    case .bottom:
      return CGRect(
        origin: CGPoint(x: popoverOrigin.x - popoverSize.width / 2, y: popoverOrigin.y - popoverSize.height),
        size: popoverSize
      )
    case .bottomLeft:
      return CGRect(
        origin: CGPoint(x: popoverOrigin.x, y: popoverOrigin.y - popoverSize.height),
        size: popoverSize
      )
    case .left:
      return CGRect(
        origin: CGPoint(x: popoverOrigin.x, y: popoverOrigin.y - popoverSize.height / 2),
        size: popoverSize
      )
    case .center:
      return CGRect(
        origin: CGPoint(x: popoverOrigin.x - popoverSize.width / 2, y: popoverOrigin.y - popoverSize.height / 2),
        size: popoverSize
      )
    }
  }
}

public extension CGRect {
  func point(at anchor: Position.Anchor) -> CGPoint {
    switch anchor {
    case .topLeft:
      return origin
    case .top:
      return CGPoint(
        x: origin.x + width / 2,
        y: origin.y
      )
    case .topRight:
      return CGPoint(
        x: origin.x + width,
        y: origin.y
      )
    case .right:
      return CGPoint(
        x: origin.x + width,
        y: origin.y + height / 2
      )
    case .bottomRight:
      return CGPoint(
        x: origin.x + width,
        y: origin.y + height
      )
    case .bottom:
      return CGPoint(
        x: origin.x + width / 2,
        y: origin.y + height
      )
    case .bottomLeft:
      return CGPoint(
        x: origin.x,
        y: origin.y + height
      )
    case .left:
      return CGPoint(
        x: origin.x,
        y: origin.y + height / 2
      )
    case .center:
      return CGPoint(
        x: origin.x + width / 2,
        y: origin.y + height / 2
      )
    }
  }
}
