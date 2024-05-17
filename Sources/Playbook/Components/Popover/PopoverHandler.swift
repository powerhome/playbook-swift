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
      .environmentObject(popoverManager)
      .overlay(
        GlobalPopoverView()
          .environmentObject(popoverManager)
      )
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
      if popoverManager.isPresented, let content = popoverManager.view {
        content
          .position(popoverManager.position)
          .onTapGesture {
            closeInside
          }
      }
    }
    .background(Color.black.opacity(popoverManager.background))
    .onTapGesture {
      closeOutside
    }
  }

  private var closeInside: Void {
    switch popoverManager.close.0 {
    case .inside, .anywhere:
      onClose()
    case .outside:
      break
    }
  }
  
  private var closeOutside: Void {
    switch popoverManager.close.0 {
    case .inside:
      break
    case .outside, .anywhere:
      onClose()
    }
  }
  
  private func onClose() {
    if let closeAction = popoverManager.close.action {
      popoverManager.isPresented = false
      closeAction()
    } else {
      popoverManager.isPresented = false
    }
  }
}
