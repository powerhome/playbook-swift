//
//  PBCard.swift
//
//
//  Created by Alexandre Hauber on 23/07/21.
//

import SwiftUI

public enum PBCardStyle {
  case `default`, selected, error

  var color: Color {
    switch self {
    case .default:
      return .border
    case .selected:
      return .pbPrimary
    case .error:
      return .status(.error)
    }
  }

  var lineWidth: CGFloat {
    switch self {
    case .default, .error:
      return 1
    case .selected:
      return 1.6
    }
  }
}

public struct PBCard<Content: View>: View {
  let content: Content
  let alignment: Alignment
  let border: Bool
  let borderRadius: CGFloat
  let highlight: Highlight
  let highlightColor: Color
  let isHovering: Bool
  let padding: CGFloat
  let style: PBCardStyle
  let shadow: Shadow?
  let width: CGFloat?

  public init(
    alignment: Alignment = .leading,
    border: Bool = true,
    borderRadius: CGFloat = BorderRadius.medium,
    highlight: Highlight = .none,
    highlightColor: Color = .product(.product1, category: .highlight),
    isHovering: Bool = false,
    padding: CGFloat = Spacing.medium,
    style: PBCardStyle = .default,
    shadow: Shadow? = nil,
    width: CGFloat? = .infinity,
    @ViewBuilder content: () -> Content
  ) {
    self.content = content()
    self.alignment = alignment
    self.border = border
    self.borderRadius = borderRadius
    self.highlight = highlight
    self.isHovering = isHovering
    self.padding = padding
    self.style = style
    self.shadow = shadow
    self.width = width
    self.highlightColor = highlightColor
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.none) {
      if highlight == .none {
        content
          .padding(padding)
      } else {
        content
          .padding(padding)
          .frame(minWidth: 0, maxWidth: .infinity, alignment: alignment)
          .background(
            RoundedRectangle(cornerRadius: borderRadius)
              .stroke(highlightColor, lineWidth: 10)
              .padding(
                .init(
                  top: highlight == .top ? 0 : -10,
                  leading: highlight == .side ? 0 : -10,
                  bottom: -10,
                  trailing: -10
                )
              )
          )
      }
    }
    .cornerRadius(borderRadius)
    .frame(minWidth: 0, maxWidth: width, alignment: alignment)
    .background(
      RoundedRectangle(cornerRadius: borderRadius, style: .continuous)
        .fill(Color.card.opacity(isHovering ? 0.4 : 1))
        .pbShadow(shadow ?? .none)
    )
    .overlay(
      RoundedRectangle(cornerRadius: borderRadius)
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
    case side
    case top
  }
}

@available(macOS 13.0, *)
struct PBCard_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return CardCatalog()
  }
}
