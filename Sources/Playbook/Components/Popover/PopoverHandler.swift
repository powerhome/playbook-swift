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
  var popoverManager: PopoverManager

  func body(content: Content) -> some View {
    content.overlay(
      ZStack {
        if popoverManager.isPresented {
          popoverManager.view
            .position(popoverManager.position ?? .zero)
            .onTapGesture {
              closeInside
            }
        }
      }
        .background(Color.white.opacity(0.01))
        .onTapGesture {
          closeOutside
        }
    )
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

public extension View {
  func withPopoverHandling(_ manager: PopoverManager) -> some View {
    self.modifier(PopoverHandler(popoverManager: manager))
  }
}

@Observable
public final class PopoverManager {
  public init(
    isPresented: Bool = false,
    position: CGPoint? = nil,
    view: AnyView? = nil,
    close: (Close, action: (() -> Void)?) = (.anywhere, nil)
  ) {
    self.isPresented = isPresented
    self.position = position
    self.view = view
    self.close = close
  }
  var isPresented: Bool
  var position: CGPoint?
  var view: AnyView?
  var close: (Close, action: (() -> Void)?)
  
  public enum Close {
    case inside, outside, anywhere
  }
}
