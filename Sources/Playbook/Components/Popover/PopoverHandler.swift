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
  @StateObject var popoverManager: PopoverManager

  func body(content: Content) -> some View {
    content
      .overlay(
        ZStack {
          if popoverManager.isPresented {
            popoverManager.view
              .position(popoverManager.position ?? .zero)
              .onTapGesture {
                closeInside
              }
          }
        }
          .background(Color.black.opacity(popoverManager.background))
          .onTapGesture {
            closeOutside
          }
          .animation(.easeIn(duration: 0.1), value: popoverManager.isPresented)
      )
      .cancelFirstResponder()
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

public final class PopoverManager: ObservableObject {
  @Published var isPresented: Bool
  @Published var position: CGPoint?
  @Published var view: AnyView?
  @Published var close: (Close, action: (() -> Void)?)
  @Published var background: CGFloat

  public init(
    isPresented: Bool = false,
    position: CGPoint? = nil,
    view: AnyView? = nil,
    background: CGFloat = 0,
    close: (Close, action: (() -> Void)?) = (.anywhere, nil)
  ) {
    self.isPresented = isPresented
    self.position = position
    self.view = view
    self.background = background
    self.close = close
  }

  public enum Close {
    case inside, outside, anywhere
  }
}
