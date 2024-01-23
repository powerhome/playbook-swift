//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  View+ReactionButtonStyle.swift
//

import SwiftUI

public extension View {
  func reactionButtonStyle(isHighlighted: Bool, isInteractive: Bool, isHovering: Bool) -> some View {
    modifier(ReactionButtonModifier(isHighlighted: isHighlighted, isInteractive: isInteractive, isHovering: isHovering))
  }
}

struct ReactionButtonModifier: ViewModifier {
 let isHighlighted: Bool
  let isInteractive: Bool
  let isHovering: Bool
  
  func body(content: Content) -> some View {
    content
      .padding(.vertical, 2)
      .frame(height: 28)
      .background(
          Capsule(style: .continuous)
            .strokeBorder(isHighlighted && isInteractive ? Color.pbPrimary : Color.border ,lineWidth: isHighlighted && isInteractive ? 2.0 : 1.0)
            .background(isHovering ? Color.background(.light) : Color.white)
            .animation(.easeInOut(duration: 0.3), value: isHighlighted)
            .animation(.easeInOut(duration: 0.3), value: isHovering)
      )
      .clipShape(Capsule())
      .onHover { hovering in
#if os(macOS)
        if hovering {
            NSCursor.pointingHand.push()
        } else {
            NSCursor.pointingHand.pop()
        }
#endif
      }
  }
}
