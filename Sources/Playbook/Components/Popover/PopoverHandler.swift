//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverHandler.swift
//

import SwiftUI

struct PopoverHandler: ViewModifier {
  let popoverManager = PopoverManager.shared

  func body(content: Content) -> some View {
    content
      .overlay(
        GlobalPopoverView()
      )
      .environmentObject(popoverManager)
  }
}

public extension View {
  func popoverHandler() -> some View {
    self.modifier(PopoverHandler())
  }
}

struct GlobalPopoverView: View {
  @EnvironmentObject var popoverManager: PopoverManager

  var body: some View {
    ZStack {
      let list = popoverManager.popovers.sorted(by: { $0.key <= $1.key} )
      ForEach(list, id: \.key) { key, popover in
//        if let position = popover.position {
          ZStack {
            Color.clear
              .onTapGesture {
                closeOutside(key)
              }
            popover.view
              .position(popover.position ?? .zero)
              .onTapGesture {
                closeInside(key)
              }
          }
//        }
      }
    }
  }

  private func closeInside(_ key: Int) -> Void {
    switch popoverManager.close.0 {
    case .inside, .anywhere:
      popoverManager.popovers.removeValue(forKey: key)
      onClose(key)
    case .outside:
      break
    }
  }
  
  private func closeOutside(_ key: Int) -> Void {
    switch popoverManager.close.0 {
    case .inside:
      break
    case .outside, .anywhere:
      popoverManager.popovers.removeValue(forKey: key)
      onClose(key)
    }
  }
  
  private func onClose(_ key: Int) {
    if let closeAction = popoverManager.close.action {
      popoverManager.isPresented[key] = false
      closeAction()
    } else {
      popoverManager.isPresented[key] = false
    }
  }
}
