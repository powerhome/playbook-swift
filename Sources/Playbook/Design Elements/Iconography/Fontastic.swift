//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Fontastic.swift
//

import SwiftUI

public enum Fontastic: String, PlaybookGenericIcon, CaseIterable {
  case smilePlus = "smile-plus"

  public var unicodeString: String {
    switch self {
    case .smilePlus: return "\u{0072}"
    }
  }

  public var fontFamily: String { "untitled-font-1" }
}

public extension PBIcon {
  static func fontastic(_ icon: Fontastic, size: IconSize = .x1) -> PBIcon {
    PBIcon(icon, size: size)
  }
}
