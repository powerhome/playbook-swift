//
//  ToastHandler.swift
//  
//
//  Created by Isis Silva on 18/10/23.
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
