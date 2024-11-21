//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverExploration.swift
//

import SwiftUI

struct PopView: View {
    @Binding var isPresented: Bool
    var body: some View {
        PBCard(
          border: false,
          padding: Spacing.small,
          shadow: .deeper,
          width: nil) {
            Text("I'm a popover. I can show content of any size.")
                .pbFont(.body, color: .text(.default))
        }
          .onTapGesture {
              isPresented = false
          }
    }
}

extension View {
    func handlerPopoverController<Content: View>(isPresented: Binding<Bool>, position: CGPoint, @ViewBuilder content: @escaping (() -> Content)) -> some View {
//        #if os(macOS)
//        self.background(PopHostingView(isPresented: isPresented, content: content))
//        #elseif os(iOS)
        self.background(PopHostingView(isPresented: isPresented, position: position, content: content))
//        #endif
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
        let contentController: NSHostingController<Content>
        @Binding var isPresented: Bool

        init(isPresented: Binding<Bool>, content: Content) {
            self.popover = NSPopover()
            self.contentController = NSHostingController(rootView: content)
            self._isPresented = isPresented

            super.init()
            self.popover.contentViewController = contentController
            self.popover.behavior = .transient
        }

        func showPopover(from sender: NSView) {
            var positioningView: NSView?
            positioningView = NSView()
            positioningView?.frame = sender.frame
            if let view = positioningView {
                sender.superview?.addSubview(view, positioned: .below, relativeTo: sender)
            }

            popover.contentViewController = PopViewController()
            popover.behavior = .transient
            popover.show(relativeTo: .zero, of: positioningView!, preferredEdge: .minY)

            positioningView?.frame = NSMakeRect(0, 200, 0, 0)
        }

        func dismissPopover() {
            popover.performClose(nil)
        }
    }

    class PopViewController: NSViewController {
        override func loadView() {
            let hostingView = NSHostingView(rootView: PopView(isPresented: .constant(false)))
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

        var popoverView: UIView?

        init(isPresented: Binding<Bool>, position: CGPoint, content: Content) {
            self.contentViewController = UIHostingController(rootView: content)
            self._isPresented = isPresented
            self.position = position
            super.init()

            let hostingView = UIHostingController(rootView: PopView(isPresented: $isPresented))
            let popoverView = hostingView.view
            popoverView?.frame = CGRect(x: position.x, y: position.y, width: 200, height: 100)
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
