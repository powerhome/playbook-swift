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
      .frameReader { contentFrame = $0 }
      .onChange(of: isPresented) { newValue in
        print("count view \(popoverManager.popovers.count)")
        print("count pressented \(popoverManager.isPresented.count)")
        print("count position \(popoverManager.position.count)")
        if newValue, let frame = contentFrame {
         generateView(frame)
          Timer.scheduledTimer(withTimeInterval: 0.04, repeats: false) { _ in
            popoverManager.isPresented[id.hashValue] = true
          }
        } else {
          popoverManager.isPresented[id.hashValue] = false
        }
      }
      .onChange(of: isPresented) { newValue in
        if newValue {
          popoverManager.background = background
          popoverManager.close = clickToClose
        }
      }
      .onChange(of: popoverManager.isPresented[id.hashValue]) {
        if let value = $0 {
          isPresented = value
        
        }
      }
//      .onChange(of: refreshView) { _ in
//        if let frame = contentFrame {
//          updateView(frame)
//        }
//      }
//      .onChange(of: contentFrame ?? .zero) { frame in
//        updateViewOnResize(frame)
//      }
      .onDisappear {
        popoverManager.isPresented.removeValue(forKey: id.hashValue)
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

  private func generateView(_ frame: CGRect) {
    let anyView = AnyView(
      variant.view(popoverView())
        .frame(width: variant.width(contentFrame?.width))
        .sizeReader { size in
          let popoverFrame = position.calculateFrame(from: variant.offset(frame, position: position), size: size)
          let popoverPosition = popoverFrame.point(at: .center())
         
          popoverManager.position[id.hashValue] = popoverPosition
        }
    )

    popoverManager.popovers[id.hashValue] = anyView
    print("view id: \(id.hashValue)")
  }
  
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
