//
//  PBCard.swift
//
//
//  Created by Alexandre Hauber on 23/07/21.
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
    self.content = content()
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.none) {
      content
        .padding(padding)
    }
    .frame(maxWidth: width, alignment: alignment)
    .border(width: 5, edges: highlight.edge, color: highlight.color)
    .cornerRadius(borderRadius)
    .background(
      RoundedRectangle(cornerRadius: borderRadius, style: .circular)
        .fill(backgroundColor)
        .pbShadow(shadow ?? .none)
    )
    .overlay(
      RoundedRectangle(cornerRadius: borderRadius, style: .circular)
        .stroke(
          style.color,
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
}

struct PBCard_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return CardCatalog()
  }
}
