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
  var customColor: Color?

  public init(
    text: String,
    style: BadgeStyle = .rectangle,
    variant: Variant = .primary,
    customColor: Color? = nil
  ) {
    self.text = text
    self.style = style
    self.variant = variant
    self.customColor = customColor
  }

  public var body: some View {
    badgeView
  }
}

public extension PBBadge {

  var badgeView: some View {
    Text(text)
      .padding(1)
      .padding(style.padding(for: text))
      .foregroundColor(variant.foregroundColor(customColor: customColor))
      .background(variant.backgroundColor())
      .background(.white)
      .pbFont(.badgeText)
      .clipShape(style.shape())

  }

  enum BadgeStyle {
    case rectangle
    case rounded
    case notification
    case custom(shape: AnyShape, padding: EdgeInsets)

    func shape() -> AnyShape {
      switch self {
      case .rectangle:
        return AnyShape(RoundedRectangle(cornerRadius: 4))
      case .rounded:
        return AnyShape(RoundedRectangle(cornerRadius: 9))
      case .notification:
        return AnyShape(Capsule())
      case .custom(let shape, _):
        return AnyShape(shape)
      }
    }

    func padding(for text: String) -> EdgeInsets {
      switch self {
      case .rectangle, .rounded:
        return EdgeInsets(top: 2.5, leading: 4, bottom: 1.5, trailing: 4)
      case .notification:
        return EdgeInsets(top: 3.5, leading: 7, bottom: 3.5, trailing: 7)
      case .custom(_, let padding):
        return padding
      }
    }
  }

  enum Variant: CaseIterable, Hashable {
    public static var allCases: [PBBadge.Variant] = []
    
    case chat
    case error
    case info
    case neutral
    case primary
    case success
    case warning
    case custom(customColor: Color)

    public static var standardVariants: [Variant] {
            return [.chat, .error, .info, .neutral, .primary, .success, .warning]
    }

  func foregroundColor(customColor: Color? = nil) -> Color {
    switch self {
    case .chat: return .white
    case .error: return .status(.error)
    case .info: return .status(.info)
    case .neutral: return .text(.light)
    case .primary: return .pbPrimary
    case .success: return .text(.successSmall)
    case .warning: return .status(.warning)
    case .custom(let customColor):
      return customColor
    }
  }

    func backgroundColor() -> Color {

      switch self {
      case .chat:
        return Color.pbPrimary
      case .custom(let customColor): return customColor.opacity(0.12)
      default:
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
