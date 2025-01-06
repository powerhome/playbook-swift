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
  case top(_ xOffset: CGFloat = 0, _ yOffset: CGFloat = 0)
  case trailing(_ xOffset: CGFloat = 0, _ yOffset: CGFloat = 0)
  case bottom(_ xOffset: CGFloat = 0, _ yOffset: CGFloat = 0)
  case leading(_ xOffset: CGFloat = 0, _ yOffset: CGFloat = 0)
  case center(_ xOffset: CGFloat = 0, _ yOffset: CGFloat = 0)
}

public extension Position {
  var popoverAnchor: Position {
    switch self {
    case .top: return .bottom()
    case .trailing: return .leading()
    case .bottom: return .top()
    case .leading: return .trailing()
    case .center: return .top()
    }
  }

  func space(_ space: CGFloat) -> CGPoint {
    switch self {
    case .top(let xOffset, let yOffset):
      return CGPoint(x: xOffset, y: yOffset - space)
    case .trailing(let xOffset, let yOffset):
      return CGPoint(x: xOffset + space, y: yOffset)
    case .bottom(let xOffset, let yOffset):
      return CGPoint(x: xOffset, y: yOffset + space)
    case .leading(let xOffset, let yOffset):
      return CGPoint(x: xOffset, y: yOffset - space)
    case .center(let xOffset, let yOffset):
      return CGPoint(x: xOffset, y: yOffset)
    }
  }

  func calculateFrame(from originFrame: CGRect?, size: CGSize?) -> CGRect {
      let popoverFrame = self.absoluteFrame(
        position: self,
        originFrame: originFrame ?? .zero,
        popoverSize: size ?? .zero
      )
//      let screenEdgePadding = EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
//      let safeWindowFrame = Screen.rect
//      let maxX = safeWindowFrame.maxX - screenEdgePadding.trailing
//      let maxY = safeWindowFrame.maxY - screenEdgePadding.bottom
//      #if os(macOS)
//      if popoverFrame.origin.x < screenEdgePadding.leading {
//        popoverFrame.origin.x = screenEdgePadding.leading
//      }
//      if popoverFrame.origin.y < screenEdgePadding.top {
//        popoverFrame.origin.y = screenEdgePadding.top
//      }
//      if popoverFrame.maxX > maxX {
//        let difference = popoverFrame.maxX - maxX
//        popoverFrame.origin.x -= difference
//      }
//      if popoverFrame.maxY > maxY {
//        let difference = popoverFrame.maxY - maxY
//        popoverFrame.origin.y -= difference
//      }
//      #endif
      return popoverFrame
  }
  
  private func absoluteFrame(
    position: Position,
    originFrame: CGRect,
    popoverSize: CGSize
  ) -> CGRect {
    let popoverOrigin = originFrame.point(at: position)
    switch position.popoverAnchor {
    case .top(let xOffset, let yOffset):
      return CGRect(
        origin: CGPoint(x: popoverOrigin.x - popoverSize.width / 2 + xOffset, y: popoverOrigin.y - 0 + yOffset),
        size: popoverSize
      )
    case .trailing(let xOffset, let yOffset):
      return CGRect(
        origin: CGPoint(x: popoverOrigin.x - popoverSize.width + xOffset, y: popoverOrigin.y - popoverSize.height / 2 + yOffset),
        size: popoverSize
      )
    case .bottom(let xOffset, let yOffset):
      return CGRect(
        origin: CGPoint(x: popoverOrigin.x - popoverSize.width / 2 + xOffset, y: popoverOrigin.y - popoverSize.height + yOffset),
        size: popoverSize
      )
    case .leading(let xOffset, let yOffset):
      return CGRect(
        origin: CGPoint(x: popoverOrigin.x + xOffset, y: popoverOrigin.y - popoverSize.height / 2 + yOffset),
        size: popoverSize
      )
    case .center(let xOffset, let yOffset):
      return CGRect(
        origin: CGPoint(x: popoverOrigin.x - popoverSize.width / 2 + xOffset, y: popoverOrigin.y - popoverSize.height / 2 + yOffset),
        size: popoverSize
      )
    }
  }
}

public extension CGRect {
  func point(at anchor: Position) -> CGPoint {
    switch anchor {
    case .top:
      return CGPoint(
        x: origin.x + width / 2,
        y: origin.y
      )
    case .trailing:
      return CGPoint(
        x: origin.x + width,
        y: origin.y + height / 2
      )
    case .bottom:
      return CGPoint(
        x: origin.x + width / 2,
        y: origin.y + height
      )
    case .leading:
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
