//
//  PBBadge.swift
//
//
//  Created by Alexandre Hauber on 22/07/21.
//

import SwiftUI

public struct PBBadge: View {
  var text: String
  var rounded: Bool
  var variant: Variant

  public init(text: String, rounded: Bool = false, variant: Variant = .primary) {
    self.text = text
    self.rounded = rounded
    self.variant = variant
  }

  public var body: some View {
    Text(text)
      .padding(EdgeInsets(top: 2.5, leading: 4, bottom: 1.5, trailing: 4))
      .frame(minWidth: 8)
      .foregroundColor(variant.foregroundColor())
      .background(variant.backgroundColor())
      .pbFont(.badgeText)
      .cornerRadius(rounded ? 10 : 4)
  }
}

public extension PBBadge {
  enum Variant {
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
      case .neutral: return .status(.neutral)
      case .success: return .status(.success)
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
}

public struct PBBadge_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()

    return VStack {
      HStack {
        PBBadge(text: "+1", rounded: true, variant: .primary)
        PBBadge(text: "+4", variant: .primary)
        PBBadge(text: "+1000", variant: .primary)
      }.padding(2)
      HStack {
        PBBadge(text: "+1", rounded: true, variant: .success)
        PBBadge(text: "+4", variant: .success)
        PBBadge(text: "+1000", variant: .success)
      }.padding(2)
      HStack {
        PBBadge(text: "+1", rounded: true, variant: .warning)
        PBBadge(text: "+4", variant: .warning)
        PBBadge(text: "+1000", variant: .warning)
      }.padding(2)
      HStack {
        PBBadge(text: "+1", rounded: true, variant: .error)
        PBBadge(text: "+4", variant: .error)
        PBBadge(text: "+1000", variant: .error)
      }.padding(2)
      HStack {
        PBBadge(text: "+1", rounded: true, variant: .info)
        PBBadge(text: "+4", variant: .info)
        PBBadge(text: "+1000", variant: .info)
      }.padding(2)
      HStack {
        PBBadge(text: "+1", rounded: true, variant: .neutral)
        PBBadge(text: "+4", variant: .neutral)
        PBBadge(text: "+1000", variant: .neutral)
      }.padding(2)
      HStack {
        PBBadge(text: "1", rounded: true, variant: .chat)
        PBBadge(text: "4", variant: .chat)
        PBBadge(text: "1000", variant: .chat)
      }.padding(2)
    }
    .background(Color.white)
    .previewDisplayName("Badges")
  }
}
