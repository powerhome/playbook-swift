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
  let backgroundColor: Color
  let border: Bool
  let borderRadius: CGFloat
  let highlight: Highlight
  let padding: CGFloat
  let style: PBCardStyle
  let shadow: Shadow?
  let width: CGFloat?
  let isHovering: Bool
  let content: Content
  public init(
    alignment: Alignment = .leading,
    backgroundColor: Color = .card,
    border: Bool = true,
    borderRadius: CGFloat = BorderRadius.medium,
    highlight: Highlight = .none,
    padding: CGFloat = Spacing.medium,
    style: PBCardStyle = .default,
    shadow: Shadow? = nil,
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
    .border(width: 5, edges: highlight.edge, color: highlight.color)
    .background(backgroundColor)
    .clipShape(
      RoundedRectangle(cornerRadius: borderRadius, style: .circular)
    )
    .pbShadow(shadow ?? .none)
    .overlay(
      RoundedRectangle(cornerRadius: borderRadius, style: .circular)
        .strokeBorder(
          borderColor,
          lineWidth: border ? style.lineWidth : 0
        )
    )
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
    isHovering ? .text(.light) : style.color
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
