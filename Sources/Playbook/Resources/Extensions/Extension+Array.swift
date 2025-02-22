//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  File.swift
//

import Foundation

extension Array {
  mutating public func move(from oldIndex: Index, to newIndex: Index) {
    guard oldIndex != newIndex, oldIndex >= 0, newIndex >= 0, oldIndex < count, newIndex < count else { return }

    let item = remove(at: oldIndex)
    insert(item, at: newIndex)
  }
}
