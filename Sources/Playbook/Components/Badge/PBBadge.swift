//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBBadge.swift
//

import SwiftUI

public struct PBBadge: View {
  var text: String
  var style: BadgeStyle
  var variant: Variant

  public init(
    text: String,
    style: BadgeStyle = .rectangle,
    variant: Variant = .primary

  ) {
    self.text = text
    self.style = style
    self.variant = variant
  }

  public var body: some View {
    badgeView
  }
}

public extension PBBadge {

  var badgeView: some View {
    Text(text)
      .padding(style.padding(for: text))
      .foregroundColor(variant.foregroundColor())
      .background(variant.backgroundColor())
      .background(.white)
      .pbFont(.badgeText)
      .clipShape(style.shape())

  }

  enum BadgeStyle {
    case rectangle
    case rounded
    case notification
    case custom(shape: AnyShape, padding: EdgeInsets, minWidth: CGFloat)

    func shape() -> AnyShape {
         switch self {
         case .rectangle:
           return AnyShape(RoundedRectangle(cornerRadius: 4))
         case .rounded:
           return AnyShape(RoundedRectangle(cornerRadius: 9))
         case .notification:
           return AnyShape(Capsule())
         case .custom(let shape, _, _):
             return AnyShape(shape)
         }
       }

    func padding(for text: String) -> EdgeInsets {
      switch self {
      case .rectangle, .rounded:
          return EdgeInsets(top: 2.5, leading: 4, bottom: 1.5, trailing: 4)
      case .notification:
        return EdgeInsets(top: 3.5, leading: 7, bottom: 3.5, trailing: 7)
      case .custom(_, let padding, _):
            return padding
      }
    }
  }

  enum Variant: CaseIterable {
    case chat
    case error
    case info
    case neutral
    case primary
    case success
    case warning

    func foregroundColor() -> Color {
      switch self {
      case .chat: return .white
      case .error: return .status(.error)
      case .info: return .status(.info)
      case .neutral: return .text(.light)
      case .primary: return .pbPrimary
      case .success: return .text(.successSmall)
      case .warning: return .status(.warning)
      }
    }

    func backgroundColor() -> Color {
      if self == .chat {
        return Color.pbPrimary
      } else {
        return foregroundColor().opacity(0.12)
      }
    }
  }
}

#Preview {
  registerFonts()
  return VStack {
    PBBadge(text: "+1000", style: .rectangle, variant: .primary)
    PBBadge(text: "+1000", style: .rounded, variant: .primary)
    PBBadge(text: "+1000", style: .notification, variant: .primary)
    
  }
}
