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
  func reactionButtonStyle(isHighlighted: Bool, isHovering: Bool) -> some View {
    modifier(ReactionButtonModifier(isHighlighted: isHighlighted, isHovering: isHovering))
  }
}

struct ReactionButtonModifier: ViewModifier {
  let isHighlighted: Bool
  let isHovering: Bool
  @Environment(\.colorScheme) var colorScheme
  
  func body(content: Content) -> some View {
    content
      .padding(.vertical, 2)
      .frame(height: 28)
      .background(
        Capsule(style: .continuous)
          .strokeBorder(borderColor, lineWidth: borderWidth)
          .background(backgroundColor)
          .animation(.easeInOut(duration: 0.3), value: isHighlighted)
      )
      .clipShape(Capsule())
  }
  
  var backgroundColor: Color {
    switch colorScheme {
      case .light: isHovering ? Color.background(.light) : Color.white
      case .dark: isHovering ? Color.Card.background(.dark) : Color.background(.dark)
      default: Color.background(.light)
    }
  }
  
  var borderColor: Color {
    switch colorScheme {
      case .light: isHighlighted ? Color.pbPrimary : Color.border
      case .dark: isHighlighted ? Color.pbPrimary : Color.BorderColor.borderColor(colorScheme)
      default: Color.pbPrimary
    }
  }
  
  var borderWidth: CGFloat {
     isHighlighted ? 2.0 : 1.0
   }
}
