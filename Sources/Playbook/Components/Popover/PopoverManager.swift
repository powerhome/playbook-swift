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
  @Published var popovers: [Int : Popover] = [:]

  public static let shared = PopoverManager()

  var close: (Close, action: (() -> Void)?) = (.anywhere, nil)
  var background: CGFloat = 0
  
  struct Popover {
    var view: AnyView
    var position: CGPoint?
  }
  
  
  
  func presentPopover(with id: Int) {
    isPresented[id] = true
  }
  
  func dismissPopover(with id: Int) {
    isPresented[id] = false
  }
  
  func updatePopoverPosition(with id: Int, _ position: CGPoint) {
    if let popover = popovers[id] {
      let newPopover = Popover(view: popover.view, position: position)
      popovers.updateValue(newPopover, forKey: id)
      print("popover position updated: \(newPopover.position) key: \(id)")
    }
  }

  public enum Close {
    case inside, outside, anywhere
  }
}
