//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Binding+String.swift
//

import SwiftUI

extension Binding where Value == String {
  func max(_ limit: Int) -> Self {
    if self.wrappedValue.count > limit {
      DispatchQueue.main.async {
        self.wrappedValue = String(self.wrappedValue.dropLast())
      }
    }
    return self
  }
}
