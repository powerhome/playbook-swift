//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverHandler.swift
//

import SwiftUI

struct PopoverView: View {
  let id: Int
  let blockBackgroundInteractions: Bool
  @State private var opacity: CGFloat = 0.01
  @EnvironmentObject var popoverManager: PopoverManager

  init(
    id: Int,
    blockBackgroundInteractions: Bool
  ) {
    self.id = id
    self.blockBackgroundInteractions = blockBackgroundInteractions
  }

  var body: some View {
    ZStack {
      let isPresented = popoverManager.isPresented.first { $0.key == id }?.value
      let popover = popoverManager.popovers.first { $0.key == id }?.value

      if isPresented ?? false {
        background
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        popover?.view
          .position(popover?.position ?? .zero)
          .onTapGesture {
            popoverManager.closeInside(id)
          }
          .onAppear {
            if popover?.position != nil {
              Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                opacity = 1
              }
            } else {
              opacity = 0.01
            }
          }
          .opacity(opacity)
      }
    }
  }

  var background: some View {
    if blockBackgroundInteractions {
      return  Color.white.opacity(0.01)
    } else {
      return Color.clear
    }
  }
}

public extension View {
  func popoverHandler(id: Int = 0, blockBackgroundInteractions: Bool = false) -> some View {
    let popoverManager = PopoverManager.shared
    return self
      .overlay(PopoverView(id: id, blockBackgroundInteractions: blockBackgroundInteractions))
      .onTapGesture { popoverManager.closeOutside() }
      .environmentObject(popoverManager)
  }
}

public extension View {
  func pbPopoverAppKit<Content: View>(isPresented: Binding<Bool>, position: CGPoint = .init(x: 0, y: 0), @ViewBuilder content: @escaping (() -> Content)) -> some View {
    self.background(PopHostingView(isPresented: isPresented, position: position, content: content))
  }
}



#if os(macOS)
import AppKit

struct PopHostingView<Content: View>: NSViewRepresentable {
  @Binding var isPresented: Bool
  let position: CGPoint
  let content: () -> Content

  func makeNSView(context: Context) -> NSView {
    let nsView = NSView(frame: .zero)
    return nsView
  }

  func updateNSView(_ nsView: NSView, context: Context) {
    if isPresented {
      context.coordinator.showPopover(from: nsView)
    } else {
      context.coordinator.dismissPopover()
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(isPresented: $isPresented, content: content())
  }

  class Coordinator: NSObject {
    let popover: NSPopover
    @Binding var isPresented: Bool
    let content: Content

    init(isPresented: Binding<Bool>, content: Content) {
      self.popover = NSPopover()
      self.content = content
      self._isPresented = isPresented
      super.init()
      self.popover.contentViewController = PopViewController(contentView: content)
      self.popover.behavior = .transient
    }

    func showPopover(from sender: NSView) {
      var positioningView: NSView?
      positioningView = NSView()
      positioningView?.frame = sender.frame
      if let view = positioningView {
        sender.superview?.addSubview(view, positioned: .below, relativeTo: sender)
      }

      popover.contentViewController = PopViewController(contentView: content)
      popover.behavior = .transient
      popover.show(relativeTo: .zero, of: positioningView!, preferredEdge: .minY)

      positioningView?.frame = NSMakeRect(0, 200, 0, 0)
    }

    func dismissPopover() {
      popover.performClose(nil)
    }
  }

  class PopViewController: NSViewController {
    private let contentView: Content

    init(contentView: Content) {
      self.contentView = contentView
      super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
      let hostingView = NSHostingView(rootView: contentView)
      hostingView.layoutSubtreeIfNeeded()
      let contentSize = hostingView.fittingSize
      let popoverView = NSView(frame: CGRect(origin: .zero, size: contentSize))
      hostingView.frame = popoverView.bounds
      popoverView.addSubview(hostingView)
      self.view = popoverView
    }
  }
}
#endif

#if os(iOS)
import UIKit

struct PopHostingView<Content: View>: UIViewRepresentable {
  @Binding var isPresented: Bool
  let position: CGPoint
  let content: () -> Content

  func makeUIView(context: Context) -> UIView {
    let uiView = UIView(frame: .zero)
    return uiView
  }

  func updateUIView(_ uiView: UIView, context: Context) {
    if isPresented {
      context.coordinator.showPopover(from: uiView)
    } else {
      context.coordinator.dismissPopover()
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(isPresented: $isPresented, position: position, content: content())
  }

  class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
    private let contentViewController: UIHostingController<Content>
    private weak var anchorView: UIView?
    @Binding var isPresented: Bool
    private let position: CGPoint
    let content: Content

    var popoverView: UIView?

    init(isPresented: Binding<Bool>, position: CGPoint, content: Content) {
      self.contentViewController = UIHostingController(rootView: content)
      self._isPresented = isPresented
      self.position = position
      self.content = content
      super.init()

      let hostingView = UIHostingController(rootView: content)
      let popoverView = hostingView.view
      popoverView?.frame = CGRect(x: position.x, y: position.y, width: 400, height: 400)
      popoverView?.layer.cornerRadius = 10
      popoverView?.backgroundColor = .clear
      self.popoverView = popoverView
    }

    func showPopover(from anchorView: UIView) {
      guard let rootVC = anchorView.window?.rootViewController else { return }

      rootVC.modalPresentationStyle = .popover
      if let popoverView = popoverView {
        rootVC.view.addSubview(popoverView)
      }
    }

    func dismissPopover() {
      if let popoverView = popoverView {
        popoverView.removeFromSuperview()
      }
    }
  }
}
#endif
