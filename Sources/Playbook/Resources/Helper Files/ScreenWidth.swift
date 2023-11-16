//
//  ScreenWidth.swift
//  
//
//  Created by Isis Silva on 09/11/23.
//

import SwiftUI

public enum Screen {
  #if os(iOS)
  static var deviceWidth: CGFloat = UIScreen.main.bounds.width
  #elseif os(macOS)
  static var deviceWidth: CGFloat = NSScreen.main?.frame.width ?? 500
  #endif
}
