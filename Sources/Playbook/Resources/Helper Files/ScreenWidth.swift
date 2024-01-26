//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ScreenWidth.swift
//

import SwiftUI

public enum Screen {
  #if os(iOS)
  static var deviceWidth: CGFloat = UIScreen.main.bounds.width
  #elseif os(macOS)
  static var deviceWidth: CGFloat = NSScreen.main?.frame.width ?? 500
  #endif
}
