//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ToastHandler.swift
//

import SwiftUI

struct ToastHandler: ViewModifier {
  @Environment(\.toastValue) var toast
  let position: PBToast.Position

  func body(content: Content) -> some View {
    content.overlay(toastView())
  }

  func toastView() -> some View {
    VStack {
      switch position {
      case .topLeft, .top, .topRight:
        toast
          .padding(.top)
          .padding(.horizontal)
        Spacer()
      case .bottomLeft, .bottom, .bottomRight:
        Spacer()
        toast
          .padding(.bottom)
          .padding(.horizontal)
      }
    }.frame(maxWidth: .infinity, alignment: position.alignment)
  }
}

public extension View {
  func withToastHandling(_ toast: PBToast?, position: PBToast.Position = .top) -> some View {
    self
      .modifier(ToastHandler(position: position))
      .environment(\.toastValue, toast)
  }
}
