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
  
  struct Popover {
    var view: AnyView
    var position: CGPoint?
    var close: (Close, action: (() -> Void)?) = (.anywhere, nil)
  }
  
  func createPopover(with id: Int, view: AnyView, position: CGPoint?, close: (Close, action: (() -> Void)?)) {
    popovers[id] = Popover(view: view, position: position, close: close)
    isPresented[id] = false
  }
  
  func removeValues() {
    popovers.removeAll()
    isPresented.removeAll()
  }
  
  func presentPopover(with id: Int, value: Bool) {
    isPresented.updateValue(value, forKey: id)
  }
  
  func dismissPopover(with id: Int) {
    isPresented[id] = false
  }
  
  func updatePopover(with id: Int, view: AnyView, position: CGPoint?) {
    if let popover = popovers.first(where: { $0.key == id })?.value, let position = position {
      let newPopover = Popover(view: view, position: position, close: popover.close)
      popovers.updateValue(newPopover, forKey: id)
    }
  }

  public enum Close {
    case inside, outside, anywhere
  }
}
