//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverView.swift
//

import SwiftUI

public struct PopoverView<Content: View>: View {
  let popover: Content
//  let position: Position
//  let parentFrame: CGRect
//  let clickToClose: Close
  let cardPadding: CGFloat = Spacing.small
  let backgroundOpacity: Double = 0
//  let dismissAction: (() -> Void)

//  @State private var yOffset: CGFloat = .zero
//  @State private var xOffset: CGFloat = .zero

//  public init(
//    position: Position,
//    clickToClose: Close,
//    cardPadding: CGFloat,
//    backgroundOpacity: Double,
//    parentFrame: CGRect,
//    dismissAction: @escaping (() -> Void),
//    @ViewBuilder popover: () -> Content
//  ) {
//    self.position = position
//    self.clickToClose = clickToClose
//    self.cardPadding = cardPadding
//    self.backgroundOpacity = backgroundOpacity
//    self.parentFrame = parentFrame
//    self.dismissAction = dismissAction
//    self.popover = popover()
//  }

  public var body: some View {
      popoverView
    .background(Color.black.opacity(backgroundOpacity))
    
//    .onTapGesture {
//      switch clickToClose {
//      case .outside, .anywhere:
//        dismissAction()
//      case .inside:
//        break
//      }
//    }
  }

  private var popoverView: some View {
    PBCard(
      border: false,
      padding: cardPadding,
      shadow: .deeper,
      width: nil
    ) {
      popover
    }
//    .onTapGesture {
//      switch clickToClose {
//      case .inside, .anywhere:
//        dismissAction()
//      case .outside:
//        break
//      }
//    }
    .preferredColorScheme(.light)
  }
}

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

extension View {
  func pbPopover<T: View>(
    isPresented: Binding<Bool>,
    popoverManager: PopoverManager,
    popoverView: @escaping () -> T
  ) -> some View {
    modifier(
      PopoverModifier(
      isPresented: isPresented,
      popoverManager: popoverManager,
      popoverView: popoverView)
    )
  }
}

struct PopoverModifier<T: View>: ViewModifier {
  @Binding var isPresented: Bool
  @State var contentFrame: CGRect?
  private var position: Position
  var popoverManager: PopoverManager
  var popoverView: () -> T
  
  public init(
    isPresented: Binding<Bool>,
    position: Position = .absolute(originAnchor: .bottom, popoverAnchor: .top),
    popoverManager: PopoverManager,
    popoverView: @escaping (() -> T)
  ) {
    self._isPresented = isPresented
    self.position = position
    self.popoverManager = popoverManager
    self.popoverView = popoverView
  }
  
  func body(content: Content) -> some View {
      content
      .background(GeometryReader { geo in
        Color.clear.onAppear { contentFrame = geo.frame(in: .scrollView) }})
        .onChange(of: isPresented) { _, newValue in
          if newValue, let frame = contentFrame {
            popoverManager.view = AnyView(
              PopoverView(popover: popoverView())
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
}

#Preview {
  registerFonts()
  return PopoverCatalog()
}


struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

struct FrameModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
          Color.clear.preference(key: FramePreferenceKey.self, value: geometry.frame(in: .global))
        }
    }

    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}
