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
  private let position: Position = .bottom()

  var body: some View {
    ZStack {
      if popoverManager.isPresented, let content = popoverManager.view {
        Color.black.opacity(background)
          .onTapGesture {
            closeOutside
          }

        content
          .position(popoverManager.position)
          .onTapGesture {
            closeInside
          }
      }
    }
    .edgesIgnoringSafeArea(.all)
  }
  
  private var background: CGFloat {
    switch popoverManager.close.0 {
    case .outside, .anywhere: return 0.001
    case .inside: return 0
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
