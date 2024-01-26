//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Font+Message.swift
//

import SwiftUI

extension Font {
  static let messageTitleFont = Font.custom(
    ProximaNova.bold.rawValue,
    size: 14,
    relativeTo: .title3
  )

  static let messageBodyFont = Font.custom(
    PBFont.proximaNovaLight,
    size: 15,
    relativeTo: .body
  )
}
