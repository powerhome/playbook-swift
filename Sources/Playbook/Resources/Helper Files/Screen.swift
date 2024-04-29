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
  static let safeAreaLayoutFrame = UIWindow().safeAreaLayoutGuide.layoutFrame
  #elseif os(macOS)
  static var deviceWidth: CGFloat = NSScreen.main?.frame.width ?? 500
  static let safeAreaLayoutFrame = NSWindow().contentLayoutRect
  #endif
}

extension Screen {
#if os(macOS)
    static var size: CGSize = NSScreen.main?.visibleFrame.size ?? NSScreen.main?.frame.size ?? CGSizeMake(0, 0)
  static var rect: CGRect = CGRect(origin: .zero, size: size)
#elseif os(iOS)
    static var size: CGSize = UIScreen.main.bounds.size
  static var rect: CGRect = CGRect(origin: .zero, size: size)
#elseif os(watchOS)
    static var size: CGSize = WKInterfaceDevice.current().screenBounds.size
#endif
    static var minX: CGFloat { 0 }
    static var minY: CGFloat { 0 }
    static var maxX: CGFloat { size.width }
    static var maxY: CGFloat { size.height }
    static var midX: CGFloat { (maxX - minX) / 2 }
    static var midY: CGFloat { (maxY - minY) / 2 }
}
