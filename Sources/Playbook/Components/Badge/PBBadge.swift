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
  var rounded: Bool
  var variant: Variant

  public init(
    text: String,
    rounded: Bool = false,
    variant: Variant = .primary
  ) {
    self.text = text
    self.rounded = rounded
    self.variant = variant
  }

  public var body: some View {

    if !text.contains("+") {
      notificationBadge
    } else {
      badgeView
    }
  }
}

public extension PBBadge {
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
      case .success: return .text(.successSmall)
      case .warning: return .status(.warning)
      default: return .pbPrimary
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

  var badgeView: some View {
    Text("\(text)")
      .padding(EdgeInsets(top: 2.5, leading: 4, bottom: 1.5, trailing: 4))
      .frame(minWidth: 8)
      .foregroundColor(variant.foregroundColor())
      .background(variant.backgroundColor())
      .background(.white)
      .pbFont(.badgeText)
      .cornerRadius(rounded ? 9 : 4)
  }

  var notificationBadge: some View {
    Text(text)
      .padding(3)
      .padding(.trailing, 1)
      .padding(.horizontal, 2.5)
      .foregroundColor(variant.foregroundColor())
      .background(variant.backgroundColor())
      .background(.white)
      .pbFont(.badgeText)
      .clipShape(Capsule())
  }
}

#Preview {
  registerFonts()
  return PBBadge(text: "+1000", variant: .primary)
}
