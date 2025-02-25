//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Collection+Identifiable.swift
//

import SwiftUI

extension Collection {
  func identifiable() -> [IdentifiableWrapper<Element>] {
      self.map { IdentifiableWrapper($0) }
  }
}
