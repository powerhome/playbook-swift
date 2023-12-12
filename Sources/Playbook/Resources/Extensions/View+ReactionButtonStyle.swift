//
//  View+ReactionButtonStyle.swift
//
//
//  Created by Rachel Radford on 12/11/23.
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
          .strokeBorder(isHighlighted && isInteractive ? Color.pbPrimary : Color.border ,lineWidth: isHighlighted ? 2.0 : 1.0)
          .background(isHovering ? Color.background(.light) : Color.white)
      )
      .clipShape(Capsule())
      .onHover { hovering in
#if os(macOS)
        if hovering {
          NSCursor.closedHand.push()
        } else {
          NSCursor.closedHand.pop()
        }
#endif
      }
  }
}
