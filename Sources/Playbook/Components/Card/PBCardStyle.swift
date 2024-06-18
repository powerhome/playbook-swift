//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBCardStyle.swift
//

import SwiftUI

public enum PBCardStyle {
  case `default`
  case selected(type: SelectedType = .card)
  case error
  case inline

  var color: Color {
    switch self {
    case .default:
      return .border
    case .selected:
      return .pbPrimary
    case .error:
      return .status(.error)
    case .inline:
      return .clear
    }
  }

  var lineWidth: CGFloat {
    switch self {
    case .default:
      return 1
    case .selected(let type):
      return type == .card ? 2 : 1
    case .error:
      return 2
    case .inline:
      return 0
    }
  }

  public enum SelectedType {
    case card, textInput
  }
}
