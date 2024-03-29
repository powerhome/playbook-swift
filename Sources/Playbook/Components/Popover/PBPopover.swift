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
  @Binding var isPresented: Bool
  private let position: Position
  private let variant: Variant
  private let popoverManager: PopoverManager
  private let clickToClose: Popover<T>.Close
  private var popoverView: () -> T
  @State private var contentFrame: CGRect?
  
  public init(
    isPresented: Binding<Bool>,
    position: Position,
    variant: Variant,
    popoverManager: PopoverManager,
    clickToClose: Close,
    popoverView: @escaping (() -> T)
  ) {
    self._isPresented = isPresented
    self.position = position
    self.variant = variant
    self.popoverManager = popoverManager
    self.clickToClose = clickToClose
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
                let popoverFrame = position.calculateFrame(from: offset(frame), size: size)
                popoverManager.position = popoverFrame.point(at: .center())
              }
              
          )
          popoverManager.isPresented = true
        } else {
          popoverManager.isPresented = false
        }
      }
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
      .onTapGesture {
        closeInside
      }
    case .dropdown, .custom:
      return popoverView()
        .onTapGesture {
          closeInside
        }
    }
  }
  
  private var closeInside: Void {
    switch clickToClose {
    case .inside, .anywhere:
      isPresented = false
    case .outside:
      break
    }
  }
  
  private var closeOutside: Void {
    switch clickToClose {
    case .inside:
      break
    case .outside, .anywhere:
        isPresented = false
      break
    }
  }
}

public extension Popover {
  enum Variant {
    case `default`, dropdown, custom
  }
  
  enum Close {
    case inside, outside((() -> Void)?), anywhere
  }
}

public extension View {
  func pbPopover<T: View>(
    isPresented: Binding<Bool>,
    position: Position = .bottom(),
    variant: Popover<T>.Variant = .default,
    popoverManager: PopoverManager,
    clickToClose: Popover<T>.Close = .anywhere,
    popoverView: @escaping () -> T
  ) -> some View {
    modifier(
      Popover(
        isPresented: isPresented,
        position: position,
        variant: variant,
        popoverManager: popoverManager,
        clickToClose: clickToClose,
        popoverView: popoverView
      )
    )
  }
}

#Preview {
  registerFonts()
  return PopoverCatalog()
}
