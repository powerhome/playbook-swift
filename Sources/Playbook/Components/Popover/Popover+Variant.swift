//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Popover+Variant.swift
//

import SwiftUI

public extension Popover {
  enum Variant {
    case `default`, dropdown, custom

    func view(_ popoverView: some View) -> any View {
      switch self {
      case .default:
        return PBCard(
          border: false,
          padding: Spacing.small,
          shadow: .deeper,
          width: nil,
          content: { popoverView }
        )
      case .dropdown, .custom:
        return popoverView
      }
    }
    
    func width(_ width: CGFloat?) -> CGFloat? {
      switch self {
      case .default, .custom:
        return nil
      case .dropdown:
        return width
      }
    }
    
    func offset(_ frame: CGRect, position: Position) -> CGRect {
      switch self {
      case .default, .custom:
        return CGRect(
          origin: CGPoint(
            x: frame.origin.x + position.space(Spacing.small).x,
            y: frame.origin.y + position.space(Spacing.small).y
          ),
          size: frame.size
        )
      case .dropdown:
        return CGRect(
          origin: CGPoint(
            x: frame.origin.x + position.space(Spacing.xSmall).x,
            y: frame.origin.y + position.space(Spacing.xSmall).y
          ),
          size: frame.size)
      }
    }
  }
}
