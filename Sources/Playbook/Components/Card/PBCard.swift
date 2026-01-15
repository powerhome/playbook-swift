//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBCard.swift
//

import SwiftUI

public struct PBCard<Content: View>: View {
  let alignment: Alignment
  let backgroundColor: Color?
  let border: Bool
  let borderRadius: CGFloat
  let highlight: Highlight
  let padding: CGFloat
  let style: PBCardStyle
  let shadow: Shadow
  let width: CGFloat?
  let isHovering: Bool
  let content: Content
  @Environment(\.colorScheme) private var colorScheme
  public init(
    alignment: Alignment = .leading,
    backgroundColor: Color? = nil,
    border: Bool = true,
    borderRadius: CGFloat = BorderRadius.medium,
    highlight: Highlight = .none,
    padding: CGFloat = Spacing.medium,
    style: PBCardStyle = .default,
    shadow: Shadow = .none,
    width: CGFloat? = .infinity,
    isHovering: Bool = false,
    @ViewBuilder content: () -> Content
  ) {
    self.alignment = alignment
    self.backgroundColor = backgroundColor
    self.border = border
    self.borderRadius = borderRadius
    self.highlight = highlight
    self.padding = padding
    self.style = style
    self.shadow = shadow
    self.width = width
    self.isHovering = isHovering
    self.content = content()
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.none) {
      content
        .padding(padding)
    }
    .frame(maxWidth: width, alignment: alignment)
    .background(
      RoundedRectangle(cornerRadius: borderRadius, style: .circular)
        .fill(cardColor)
    )
    .overlay(
      RoundedRectangle(cornerRadius: borderRadius, style: .circular)
        .strokeBorder(
          borderColor,
          lineWidth: border ? style.lineWidth : 0
        )
    )
    .compositingGroup() 
    .pbShadow(shadowColor)
    .border(width: borderRadius, edges: highlight.edge, color: highlight.color)
  }
}

public extension PBCard {
  enum Highlight {
    case none
    case side(Color)
    case top(Color)
    
    var edge: [Edge] {
      switch self {
      case .side: return [.leading]
      case .top: return [.top]
      default: return []
      }
    }
    
    var color: Color {
      switch self {
      case .side(let color): return color
      case .top(let color): return color
      case .none: return .clear
      }
    }
  }
  var borderColor: Color {
    isHovering ? .status(.neutral) : style.color
  }
  var cardColor: Color {
    if let backgroundColor = backgroundColor {
      return backgroundColor
    } else {
      return Color.Card.background(colorScheme)
    }
  }

  var shadowColor: Shadow {
    if colorScheme == .dark {
      return shadow == Shadow.none ? .none : .shadowDark
    }
      return shadow == Shadow.none ? .none : shadow
  }
}

#Preview {
  registerFonts()
  return PBCard(
    alignment: .center,
    backgroundColor: .pink,
    border: true,
    borderRadius: BorderRadius.medium,
    highlight: .none,
    padding: Spacing.medium,
    style: .default,
    shadow: .deeper,
    content: { Text("Card Example").pbFont(.body)})
}
