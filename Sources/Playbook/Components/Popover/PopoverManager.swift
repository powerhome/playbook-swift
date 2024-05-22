//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverManager.swift
//

import SwiftUI

public class PopoverManager: ObservableObject {
  @Published var isPresented: [Int : Bool] = [:]
  @Published var popovers: [Int : AnyView] = [:]

  @Published var position: [Int : CGPoint] = [:]
  @Published var close: (Close, action: (() -> Void)?) = (.anywhere, nil)
  var background: CGFloat = 0
  
  static let shared = PopoverManager()
  
  

  public enum Close {
    case inside, outside, anywhere
  }
}
