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
  private let id: Int

  @Binding var isPresented: Bool
  @Binding var refreshView: Bool
  @State private var isHovering: Bool = false
  @State private var contentFrame: CGRect?
  @State private var popoverSize: CGSize?
  @State private var popoverPosition: CGPoint?
  @State private var popoverFrameView: AnyView?
  @EnvironmentObject var popoverManager: PopoverManager

  public init(
    isPresented: Binding<Bool>,
    id: Int?,
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
    self.id = id ?? UUID().hashValue
  }

  public func body(content: Content) -> some View {
    content
      .frameReader {
        contentFrame = $0
        popoverFrameView = generateView($0)
      }
      .onAppear {
        if let view = popoverFrameView {
          popoverManager.createPopover(
            with: id,
            view: view,
            position: popoverPosition,
            close: clickToClose
          )
        }
      }
      .onChange(of: isPresented) { newValue in
        popoverManager.presentPopover(with: id, value: newValue)
        updateViewFrame()
      }
      .onChange(of: popoverPosition) { position in
        updateViewFrame()
      }
      .onChange(of: contentFrame) { frame in
        updateViewFrame()
      }
      .onChange(of: refreshView) { _ in
        updateViewFrame()
      }
      .onChange(of: isHovering) { _ in
        updateViewFrame()
      }
      .onReceive(popoverManager.$isPresented) { newValue in
        if let value = newValue[id] {
          isPresented = value
        }
      }
      .onDisappear {
        isPresented = false
        popoverManager.removeValues()
      }
  }
}

extension Popover {
  private func generateView(_ frame: CGRect) -> AnyView {
    AnyView(
      variant.view(popoverView().onHover { isHovering = $0 })
        .frame(width: variant.width(frame.width))
        .sizeReader { size in
          popoverSize = size
          let popoverFrame = position.calculateFrame(from: variant.offset(frame, position: position), size: size)
          popoverPosition = popoverFrame.point(at: .center())
        }
    )
  }

  func updateViewFrame() {
    if let frame = contentFrame {
      let popoverFrame = position.calculateFrame(from: variant.offset(frame, position: position), size: popoverSize)
      let point = popoverFrame.point(at: .center())
      popoverManager.updatePopover(
        with: id,
        view: generateView(frame),
        position: point
      )
    }
  }
}

public extension View {
  func pbPopover<T: View>(
    isPresented: Binding<Bool>,
    id: Int? = nil,
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
