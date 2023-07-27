//
//  PBCardStyle.swift
//  
//
//  Created by Isis Silva on 14/06/23.
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
