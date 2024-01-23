//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Toast+EnvironmentKey.swift
//

import SwiftUI

private struct ToastEnvironmentKey: EnvironmentKey {
  static let defaultValue: PBToast? = nil
}

extension EnvironmentValues {
  var toastValue: PBToast? {
    get { self[ToastEnvironmentKey.self] }
    set { self[ToastEnvironmentKey.self] = newValue }
  }
}
