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
      case .top:
        toast
          .padding(.top)
        Spacer()
      case .bottom:
        Spacer()
        toast
          .padding(.bottom)
      }
    }
  }
}

func randomTestFunction(a: Int, b: Int) -> Int {
  return a * b
}

func randomSub(a: Int, b: Int) -> Int {
  return a - b
}
public extension View {
  func withToastHandling(_ toast: PBToast?, position: PBToast.Position = .top) -> some View {
    self
      .modifier(ToastHandler(position: position))
      .environment(\.toastValue, toast)
  }
}
