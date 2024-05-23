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
  let id = UUID()
  
  @Binding var isPresented: Bool
  @Binding var refreshView: Bool
  @State private var contentFrame: CGRect?
  @State private var popoverPosition: CGPoint?
  @State private var popoverFrameView: AnyView?
  @EnvironmentObject var popoverManager: PopoverManager
  
  public init(
    isPresented: Binding<Bool>,
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
  }
  
  public func body(content: Content) -> some View {
    content
      .frameReader {
        popoverFrameView = generateView($0)
      }
      .onChange(of: isPresented) { newValue in
        //        if newValue, let view = popoverFrameView, let position = popoverPosition {
        popoverManager.popovers[id.hashValue] = PopoverManager.Popover(view: popoverFrameView ?? AnyView(Color.pink), position: popoverPosition)
        print("count view \(popoverManager.popovers.count)")
        print("view id: \(id.hashValue)")
        print("popover: \(popoverManager.popovers[id.hashValue]?.position) key: \(id.hashValue)")
      }
      .onChange(of: popoverPosition) { position in
        for popover in popoverManager.popovers {
          let newPopover = PopoverManager.Popover(view: popover.value.view, position: position)
          popoverManager.popovers.updateValue(newPopover, forKey: popover.key)
          print("popover position updated: \(newPopover.position) key: \(popover.key)")
        }
      }
//      .onChange(of: popoverManager.isPresented[id.hashValue]) {
//        if let value = $0 {
//          isPresented = value
//        
//        }
//      }
//      .onChange(of: refreshView) { _ in
//        if let frame = contentFrame {
//          updateView(frame)
//        }
//      }
//      .onChange(of: contentFrame ?? .zero) { frame in
//        updateViewOnResize(frame)
//      }
      .onDisappear {
        isPresented = false
        popoverManager.popovers.removeValue(forKey: id.hashValue)
      }
  }
}

extension Popover {
  private var background: CGFloat {
    switch clickToClose.0 {
    case .outside, .anywhere: return variant == .dropdown ? 0 : 0.001
    case .inside: return 0
    }
  }
  
  private func generateView(_ frame: CGRect) -> AnyView {
    AnyView(
      variant.view(popoverView())
        .frame(width: variant.width(frame.width))
        .sizeReader { size in
          let popoverFrame = position.calculateFrame(from: variant.offset(frame, position: position), size: size)
          print("frame \(popoverFrame.size)")
          popoverPosition = popoverFrame.point(at: .center())
        }
    )
  }
  
  //  private func generateView(_ frame: CGRect) -> AnyView {
  //  AnyView(
  //      variant.view(popoverView())
  //        .frame(width: variant.width(contentFrame?.width))
//        .sizeReader { size in
//          let popoverFrame = position.calculateFrame(from: variant.offset(frame, position: position), size: size)
//          print("frame \(popoverFrame.size)")
//          popoverPosition = popoverFrame.point(at: .center())
//        }
//    )
//  }
  
  private func updateViewOnResize(_ frame: CGRect) {
    if isPresented {
      isPresented = false
      Timer.scheduledTimer(withTimeInterval: 0.02, repeats: false) { _ in
        isPresented = true
      }
    }
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
    position: Position = .bottom(),
    variant: Popover<T>.Variant = .default,
    clickToClose: (PopoverManager.Close, action: (() -> Void)?) = (.anywhere, action: nil),
    refreshView: Binding<Bool> = .constant(false),
    popoverView: @escaping () -> T
  ) -> some View {
    modifier(
      Popover(
        isPresented: isPresented,
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
