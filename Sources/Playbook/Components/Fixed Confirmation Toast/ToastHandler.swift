//
//  ToastHandler.swift
//  
//
//  Created by Isis Silva on 18/10/23.
//

import SwiftUI

struct ToastHandler: ViewModifier {
  @Environment(\.toastValue) var toast
//  @Binding var isPresented: Bool

  func body(content: Content) -> some View {
//    if isPresented {
      content
      .overlay(
        toastView()
          .simultaneousGesture(
            TapGesture().onEnded { dismiss() }
          )
      )
//    }
  }

  func toastView() -> some View {
    VStack {
      toast
        .padding(.top)
//        .animation(Animation.easeOut(duration: 0.3), value: currentOffset)
      Spacer()

    }
  }

  func dismiss() {
//    isPresented = false
  }
}

public extension View {
  func withToastHandling(_ toast: PBToast?) -> some View {
    self
      .modifier(ToastHandler())
      .environment(\.toastValue, toast)
  }
}
