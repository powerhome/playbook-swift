//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  IdentifiableWrapper.swift
//

import SwiftUI

public struct IdentifiableWrapper<Item>: Identifiable {
  public let id: UUID
  let value: Item

  init(_ value: Item) {
      self.id = UUID()
      self.value = value
  }
}

