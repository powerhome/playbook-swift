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
      content
      .overlay(
        toastView()
          .simultaneousGesture(
            TapGesture().onEnded { dismiss() }
          )
      )
  }

  func toastView() -> some View {
    VStack {
      switch position {
      case .top:
        toast
          .padding(.top)
  //        .animation(Animation.easeOut(duration: 0.3), value: currentOffset)
        Spacer()
      case .bottom:
        Spacer()
        toast
          .padding(.bottom)
  //        .animation(Animation.easeOut(duration: 0.3), value: currentOffset)
      }
     

    }
  }

  func dismiss() {
//    isPresented = false
  }
}

public extension View {
  func withToastHandling(_ toast: PBToast?, position: PBToast.Position = .top) -> some View {
    self
      .modifier(ToastHandler(position: position))
      .environment(\.toastValue, toast)
  }
}
