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
  func withPopoverHandling() -> some View {
    self.modifier(PopoverHandler())
  }
}


public class PopoverManager: ObservableObject {
  @Published var isPresented: Bool = false
  @Published var popoverContent: AnyView?
  @Published var position: CGPoint = .zero
  private let id = UUID()
  static let shared = PopoverManager()
  @Published var close: (Close, action: (() -> Void)?) = (.anywhere, nil)

  public enum Close {
    case inside, outside, anywhere
  }
}

struct GlobalPopoverView: View {
  @EnvironmentObject var popoverManager: PopoverManager
  private let position: Position = .bottom()
  
  var body: some View {
    ZStack {
      if popoverManager.isPresented, let content = popoverManager.popoverContent {
        content
          .position(popoverManager.position)
          .onTapGesture {
            closeInside
          }
      }
    }
    .edgesIgnoringSafeArea(.all)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(
      Color.black
        .opacity(popoverManager.isPresented ? 0.1 : 0)
        .edgesIgnoringSafeArea(.all)
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

//struct GlobalPopoverView: View {
//  @EnvironmentObject var popoverManager: PopoverManager
//
//  var body: some View {
//    ZStack {
//      if popoverManager.isPresented, let content = popoverManager.view, let position = popoverManager.position {
//        content
//          .background(Color.white.cornerRadius(12).shadow(radius: 10))
//          .position(position)
//          .transition(.opacity.combined(with: .scale))
//          
//          .background(
//            Color.black
//              .opacity(popoverManager.isPresented ? 0.1 : 0)
//              .edgesIgnoringSafeArea(.all)
//              .onTapGesture {
//                popoverManager.isPresented.toggle()
//          }
//                  .background(Color.black.opacity(popoverManager.background))
//                  .onTapGesture {
//                    closeOutside
//                  }
//          )
//      }
//    }
//    .edgesIgnoringSafeArea(.all)
//    .frame(maxWidth: .infinity, maxHeight: .infinity)
//
//  }
//  

//}
//
//struct PopoverHandler: ViewModifier {
//  let popoverManager = PopoverManager.shared
//
//  func body(content: Content) -> some View {
//    content
//      .environmentObject(popoverManager)
//      .overlay(
//        GlobalPopoverView()
//          .environmentObject(popoverManager)
//      )
//  }
//}
//
//public extension View {
//  func withPopoverHandling() -> some View {
//    self.modifier(PopoverHandler())
//  }
//}
//
//public final class PopoverManager: ObservableObject {
//  @Published var isPresented: Bool
//  @Published var position: CGPoint?
//  @Published var view: AnyView?
//  @Published var close: (Close, action: (() -> Void)?)
//  @Published var background: CGFloat
//  
//  static let shared = PopoverManager()
//
//  public init(
//    isPresented: Bool = false,
//    position: CGPoint? = nil,
//    view: AnyView? = nil,
//    background: CGFloat = 0,
//    close: (Close, action: (() -> Void)?) = (.anywhere, nil)
//  ) {
//    self.isPresented = isPresented
//    self.position = position
//    self.view = view
//    self.background = background
//    self.close = close
//  }
//
//  public enum Close {
//    case inside, outside, anywhere
//  }
//}
