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
  let id: Int

  @Binding var isPresented: Bool
  @Binding var refreshView: Bool
  @State private var contentFrame: CGRect?
  @State private var popoverSize: CGSize?
  @State private var popoverPosition: CGPoint?
  @State private var popoverFrameView: AnyView?
  @EnvironmentObject var popoverManager: PopoverManager

  public init(
    isPresented: Binding<Bool>,
    id: Int = 0,
    position: Position,
    variant: Variant,
    clickToClose: (PopoverManager.Close, action: (() -> Void)?),
    refreshView: Binding<Bool> = .constant(false),
    popoverView: @escaping (() -> T)
  ) {
    self._isPresented = isPresented
    self.position = position
    self.variant = variant
    self.clickToClose = clickToClose
    self._refreshView = refreshView
    self.popoverView = popoverView
    self.id = id
  }

  public func body(content: Content) -> some View {
    content
      .frameReader {
        contentFrame = $0
        popoverFrameView = generateView($0)
      }
      .onChange(of: isPresented) { newValue in
        if newValue, let view = popoverFrameView {
          popoverManager.presentPopover(with: id)
          popoverManager.popovers[id] = PopoverManager.Popover(view: view, position: popoverPosition)
        } else {
          popoverManager.dismissPopover(with: id)
          popoverManager.popovers.removeValue(forKey: id)
        }
        print("count view \(popoverManager.popovers.count)")
        print("view id: \(id.hashValue)")
//        print("popover: \(popoverManager.popovers[id]?.position) key: \(id)")
      }
      .onChange(of: popoverManager.isPresented[id]) {
        if let newValue = $0 {
          isPresented = newValue
        }
      }
      .onChange(of: popoverPosition) { position in
        if let position = position {
          popoverManager.updatePopoverPosition(with: id, position)
        }
      }
      .onChange(of: contentFrame) { frame in
        if let frame = frame {
          popoverManager.updatePopoverPosition(
            with: id,
            recalculatePostion(withParent: frame)
          )
        }
      }
      .onDisappear {
        isPresented = false
        popoverManager.popovers.removeValue(forKey: id.hashValue)
        print("on disappear count: \(popoverManager.popovers.count)")
      }
  }
}

extension Popover {
  private func generateView(_ frame: CGRect) -> AnyView {
    AnyView(
      variant.view(popoverView())
        .frame(width: variant.width(frame.width))
        .sizeReader { size in
          popoverSize = size
          let popoverFrame = position.calculateFrame(from: variant.offset(frame, position: position), size: size)
          print("frame \(popoverFrame.size)")
          popoverPosition = popoverFrame.point(at: .center())
          print("position id: \(id) \(popoverPosition)")
        }
    )
  }
  
  func recalculatePostion(withParent frame: CGRect) -> CGPoint {
    let popoverFrame = position.calculateFrame(from: variant.offset(frame, position: position), size: popoverSize)
    print("frame \(popoverFrame.size)")
    return popoverFrame.point(at: .center())
  }
}

public extension Popover {
  enum Variant {
    case `default`, dropdown, custom

    func view(_ popoverView: some View) -> any View {
      switch self {
      case .default:
        return PBCard(
          border: false,
          padding: Spacing.small,
          shadow: .deeper,
          width: nil,
          content: { popoverView }
        )
      case .dropdown, .custom:
        return popoverView
      }
    }
    
    func width(_ width: CGFloat?) -> CGFloat? {
      switch self {
      case .default, .custom:
        return nil
      case .dropdown:
        return width
      }
    }
    
    func offset(_ frame: CGRect, position: Position) -> CGRect {
      switch self {
      case .default, .custom:
        return CGRect(
          origin: CGPoint(
            x: frame.origin.x + position.space(Spacing.small).x,
            y: frame.origin.y + position.space(Spacing.small).y
          ),
          size: frame.size
        )
      case .dropdown:
        return CGRect(
          origin: CGPoint(
            x: frame.origin.x + position.space(Spacing.xSmall).x,
            y: frame.origin.y + position.space(Spacing.xSmall).y
          ),
          size: frame.size)
      }
    }
  }
}

public extension View {
  func pbPopover<T: View>(
    isPresented: Binding<Bool>,
    id: Int,
    position: Position = .bottom(),
    variant: Popover<T>.Variant = .default,
    clickToClose: (PopoverManager.Close, action: (() -> Void)?) = (.anywhere, action: nil),
    refreshView: Binding<Bool> = .constant(false),
    popoverView: @escaping () -> T
  ) -> some View {
    modifier(
      Popover(
        isPresented: isPresented,
        id: id,
        position: position,
        variant: variant,
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
