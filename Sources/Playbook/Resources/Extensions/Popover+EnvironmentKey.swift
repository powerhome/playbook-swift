//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Popover+EnvironmentKey.swift
//

import SwiftUI

private struct PopoverEnvironmentKey: EnvironmentKey {
  static let defaultValue: AnyView? = nil
}

extension EnvironmentValues {
  var popoverValue: AnyView? {
    get { self[PopoverEnvironmentKey.self] }
    set { self[PopoverEnvironmentKey.self] = newValue }
  }
}
