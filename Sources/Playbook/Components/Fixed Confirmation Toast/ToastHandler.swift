//
//  ToastHandler.swift
//  
//
//  Created by Isis Silva on 18/10/23.
//

import SwiftUI

struct ToastHandler: ViewModifier {
  @Environment(\.toastValue) var toast
  @State private var presenterContentRect: CGRect = .zero
  @State private var sheetContentRect: CGRect = .zero
  
  private var displayedOffset: CGFloat { presenterContentRect.minY }
  private var currentOffset: CGFloat { toast != nil ? displayedOffset : screenHeight }
  
  private var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
  private var screenHeight: CGFloat { UIScreen.main.bounds.size.height }

  func body(content: Content) -> some View {
    ZStack {
      content
        .frameGetter($presenterContentRect)
    }
    .overlay(sheet())
  }
  
  func sheet() -> some View {
    ZStack {
      toast
        .frameGetter($sheetContentRect)
        .frame(width: screenWidth)
        .offset(x: 0, y: -currentOffset)
        .animation(Animation.easeOut(duration: 0.3), value: currentOffset)
      
    }
  }
}

class ToastHandling: ObservableObject {
  @Published var currentToast: PBToast?
  func handle(toast: PBToast?) {
    currentToast = toast
  }
}

public extension View {
  func withToastHandling(_ toast: PBToast?) -> some View {
    self
      .modifier(ToastHandler())
      .environment(\.toastValue, toast)
  }
}
