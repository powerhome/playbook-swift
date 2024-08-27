//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBPill.swift
//

import SwiftUI

public struct PBPill: View {
  private let title: String
  private let variant: Variant

  public init(_ title: String, variant: Variant = .neutral) {
    self.title = title
    self.variant = variant
  }

  public var body: some View {
    Text(title)
      .padding(EdgeInsets(top: 1.5, leading: 9, bottom: 1.5, trailing: 9))
      .foregroundColor(variant.foregroundColor())
      .pbFont(.title4)
      .background(variant.backgroundColor())
      .cornerRadius(12)
  }
}

public extension PBPill {
  enum Variant {
    case error
    case info
    case neutral
    case primary
    case success
    case warning

    func foregroundColor() -> Color {
      switch self {
      case .error: return .status(.error)
      case .info: return .status(.info)
      case .primary: return .pbPrimary
      case .success: return .status(.success)
      case .warning: return .text(.warningText)
      default: return .text(.light)
      }
    }

    func backgroundColor() -> Color {
      foregroundColor().opacity(0.1)
    }
  }
}

struct PBPill_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return PillCatalog()
      .background(Color.card)
  }
}
