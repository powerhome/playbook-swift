//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverView.swift
//

import SwiftUI

public struct Popover<T: View>: ViewModifier {
  private let position: Position
  private let variant: Variant
  private let clickToClose: (PopoverManager.Close, action: (() -> Void)?)
  private var popoverView: () -> T
  
  @Binding var isPresented: Bool
  @State private var contentFrame: CGRect?
  @Binding var refreshView: Bool
  @ObservedObject var popoverManager: PopoverManager
  
  public init(
    isPresented: Binding<Bool>,
    position: Position,
    variant: Variant,
    popoverManager: PopoverManager,
    clickToClose: (PopoverManager.Close, action: (() -> Void)?),
    refreshView: Binding<Bool> = .constant(false),
    popoverView: @escaping (() -> T)
  ) {
    self._isPresented = isPresented
    self.position = position
    self.variant = variant
    self.popoverManager = popoverManager
    self.clickToClose = clickToClose
    self._refreshView = refreshView
    self.popoverView = popoverView
  }
  
  public func body(content: Content) -> some View {
    content
      .frameReader(isPresented: isPresented) { frame in
        contentFrame = frame
      }
      .onChange(of: isPresented) { newValue in
        if newValue, let frame = contentFrame {
          popoverManager.view = AnyView(
            view
              .onHover { refreshView = $0 }
              .frame(width: width)
              .sizeReader { size in
                let popoverFrame = position.calculateFrame(from: offset(frame), size: size)
                popoverManager.position = popoverFrame.point(at: .center())
              }
          )
          Timer.scheduledTimer(withTimeInterval: 0.08, repeats: false) { _ in
            popoverManager.isPresented = true
          }
        } else {
          popoverManager.isPresented = false
        }
      }
//      .onChange(of: isPresented) { newValue in
//        if newValue {
//          popoverManager.background = background
////          popoverManager.close = clickToClose
//        }
//      }
      .onChange(of: popoverManager.isPresented) { newValue in
        if !newValue {
          isPresented = newValue
        }
      }
      .onChange(of: refreshView) { _ in
        if let frame = contentFrame {
          updateView(frame)
        }
      }
  }
}

extension Popover {
  private func updateView(_ frame: CGRect) {
    popoverManager.view = AnyView(
      view
        .onHover { refreshView = $0 }
        .frame(width: width)
        .sizeReader { size in
          let popoverFrame = position.calculateFrame(from: offset(frame), size: size)
          popoverManager.position = popoverFrame.point(at: .center())
        }
    )
  }
  
  private func offset(_ frame: CGRect) -> CGRect {
    switch variant {
    case .default, .custom:
      return CGRect(
        origin: CGPoint(
          x: frame.origin.x + space(Spacing.small).x,
          y: frame.origin.y + space(Spacing.small).y
        ),
        size: frame.size
      )
    case .dropdown:
      return CGRect(
        origin: CGPoint(
          x: frame.origin.x + space(Spacing.xSmall).x,
          y: frame.origin.y + space(Spacing.xSmall).y
        ),
        size: frame.size)
    }
  }

  private func space(_ space: CGFloat) -> CGPoint {
    switch position {
    case .top(let xOffset, let yOffset):
      return CGPoint(x: xOffset, y:  yOffset - space)
    case .trailing(let xOffset, let yOffset):
      return CGPoint(x: xOffset + space, y:  yOffset)
    case .bottom(let xOffset, let yOffset):
      return CGPoint(x: xOffset, y:  yOffset + space)
    case .leading(let xOffset, let yOffset):
      return CGPoint(x: xOffset, y:  yOffset - space)
    case .center(let xOffset, let yOffset):
      return CGPoint(x: xOffset, y:  yOffset)
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
  
  private var background: CGFloat {
    switch variant {
    case .default, .custom:
      return 0.01
    case .dropdown:
      return 0
    }
  }
}

public extension Popover {
  enum Variant {
    case `default`, dropdown, custom
  }
}

public extension View {
  func pbPopover<T: View>(
    isPresented: Binding<Bool>,
    position: Position = .bottom(),
    variant: Popover<T>.Variant = .default,
    popoverManager: PopoverManager,
    clickToClose: (PopoverManager.Close, action: (() -> Void)?) = (.anywhere, action: nil),
    refreshView: Binding<Bool> = .constant(false),
    popoverView: @escaping () -> T
  ) -> some View {
    modifier(
      Popover(
        isPresented: isPresented,
        position: position,
        variant: variant,
        popoverManager: popoverManager,
        clickToClose: clickToClose,
        refreshView: refreshView,
        popoverView: popoverView
      )
    )
  }
}

#Preview {
  registerFonts()
  return PopoverCatalog()
}
