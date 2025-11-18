//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  CGFloat+Device.swift
//

import Foundation


extension CGFloat {
  /** Returns different value for each platform */
  static func iOS(_ val: CGFloat, macOS: CGFloat) -> CGFloat {
    #if os(iOS)
    return val
    #else
    return macOS
    #endif
  }
}
