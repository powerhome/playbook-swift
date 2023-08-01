//
//  Font+Message.swift
//  
//
//  Created by Isis Silva on 07/06/23.
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
