//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverView.swift
//

import SwiftUI

//public struct PBPopover<T: View>: ViewModifier {
//  @Binding var isPresented: Bool
//  @State private var position: CGPoint = .zero
//  let clickToClose: PopoverView<T>.Close
//  let cardPadding: CGFloat
//  let backgroundOpacity: Double
//  let popoverManager: PopoverManager
//  let dismissAction: (() -> Void)?
//  @ViewBuilder var popoverView: () -> T
//
//  init(
//    isPresented: Binding<Bool>,
//    position: PopoverView<T>.Position,
//    clickToClose: PopoverView<T>.Close,
//    cardPadding: CGFloat,
//    backgroundOpacity: Double,
//    popoverManager: PopoverManager,
//    dismissAction: (() -> Void)?,
//    popoverView: @escaping () -> T
//  ) {
//    self._isPresented = isPresented
////    self.position = position
//    self.clickToClose = clickToClose
//    self.cardPadding = cardPadding
//    self.backgroundOpacity = backgroundOpacity
//    self.popoverManager = popoverManager
//    self.dismissAction = dismissAction
//    self.popoverView = popoverView
//  }
//
//  public func body(content: Content) -> some View {
//    content.background(GeometryReader { geometry in
//      let frame = geometry.frame(in: .global)
//      Color.clear
//        .onChange(of: isPresented) { newValue in
//          print("is presented value \(newValue)")
//          if newValue {
//            position = CGPoint(x: frame.midX, y: frame.midY - 100)
//            popoverManager.view = AnyView(
////              PopoverView(
////                position: .bottom(40),
////                clickToClose: clickToClose,
////                cardPadding: cardPadding,
////                backgroundOpacity: backgroundOpacity,
////                parentFrame: frame,
////                dismissAction: dismiss
////              ) {
//                popoverView()
////              }
//            )
//            popoverManager.isPresented = true
//          } else {
//            popoverManager.isPresented = false
//          }
//        }
//    })
//  }
//
//  private var dismiss: () -> Void {
//    if let dismiss = dismissAction {
//      return dismiss
//    } else {
//      return {
//        isPresented = false
////        view = nil
//      }
//    }
//  }
//}

//public extension View {
//  func pbPopover<T: View>(
//    isPresented: Binding<Bool>,
//    position: PopoverView<T>.Position = .bottom(),
//    clickToClose: PopoverView<T>.Close = .anywhere,
//    cardPadding: CGFloat = Spacing.small,
//    backgroundOpacity: Double = 0.001,
//    popoverManager: PopoverManager,
//    dismissAction: (() -> Void)? = nil,
//    contentView: @escaping () -> T
//  ) -> some View {
//    modifier(
//      PBPopover(
//        isPresented: isPresented,
//        position: position,
//        clickToClose: clickToClose,
//        cardPadding: cardPadding,
//        backgroundOpacity: backgroundOpacity,
//        popoverManager: popoverManager,
//        dismissAction: dismissAction,
//        popoverView: contentView
//      )
//    )
//  }
//}
//
//public extension PopoverView {
//  enum Close {
//    case inside, outside, anywhere
//  }
//}

public extension View {
  func pbPopover<T: View>(
    isPresented: Binding<Bool>,
    variant: Popover<T>.Variant = .default,
    popoverManager: PopoverManager,
    popoverView: @escaping () -> T
  ) -> some View {
    modifier(
      Popover(
      isPresented: isPresented,
      variant: variant,
      popoverManager: popoverManager,
      popoverView: popoverView
      )
    )
  }
}

public struct Popover<T: View>: ViewModifier {
  @Binding var isPresented: Bool
  private var position: Position
  private var variant: Variant
  private var popoverManager: PopoverManager
  private var popoverView: () -> T
  @State private var contentFrame: CGRect?

  public init(
    isPresented: Binding<Bool>,
    position: Position = .absolute(originAnchor: .bottom, popoverAnchor: .top),
    variant: Variant,
    popoverManager: PopoverManager,
    popoverView: @escaping (() -> T)
  ) {
    self._isPresented = isPresented
    self.position = position
    self.variant = variant
    self.popoverManager = popoverManager
    self.popoverView = popoverView
  }
  
  public func body(content: Content) -> some View {
    content
      .background(GeometryReader { geo in
        Color.clear.onAppear { contentFrame = geo.frame(in: .scrollView) }})
        .onChange(of: isPresented) { _, newValue in
          if newValue, let frame = contentFrame {
            popoverManager.view = AnyView(
              view
                .frame(width: width)
                .sizeReader { size in
                  let popoverFrame = position.calculateFrame(from: frame, size: size)
                  popoverManager.position = popoverFrame.point(at: .center)
                }
            )
            popoverManager.isPresented = true
          } else {
            popoverManager.isPresented = false
          }
        }
    }
  
  private var width: CGFloat? {
    switch variant {
    case .default, .custom:
      return nil
    case .dropdown:
      return contentFrame?.width
    }
  }
  
  private var view: any View {
    switch variant {
    case .default:
      return PBCard(
        border: false,
        padding: Spacing.small,
        shadow: .deeper,
        width: nil,
        content: { popoverView() }
      )
    case .dropdown, .custom:
      return popoverView()
    }
  }
}

public extension Popover {
  enum Variant {
    case `default`, dropdown, custom
  }
}

#Preview {
  registerFonts()
  return PopoverCatalog()
}
