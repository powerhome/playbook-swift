//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  View+OSDirective.swift
//

import Foundation

extension String {
  static func iOS(_ val: String, macOS: String) -> String {
  #if os(iOS)
    return val
  #else
    return macOS
  #endif
  }

}

extension CGFloat {
  static func iOS(_ val: CGFloat, macOS: CGFloat) -> CGFloat {
#if os(iOS)
    return val
#else
    return macOS
#endif
  }
}
