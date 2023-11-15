//
//  Toast+EnvironmentKey.swift
//
//
//  Created by Isis Silva on 18/10/23.
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
