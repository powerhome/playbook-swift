//
//  FullScreenCover+View.swift
//
//
//  Created by Isis Silva on 05/09/23.
//

import SwiftUI

#if os(iOS)
extension View {
  @ViewBuilder
  func heroFullScreenCover<Content: View>(show: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
    self.modifier(HelperHeroView(show: show, overlay: content()))
  }
}

struct HelperHeroView<Overlay: View>: ViewModifier {
  @Binding var show: Bool
  var overlay: Overlay
  
  @State private var hostView: UIHostingController<Overlay>?
  @State private var parentController: UIViewController?

  func body(content: Content) -> some View {
    content
      .background {
        ExtractSwiftUIParentController(content: overlay, hostView: $hostView) { controller in
          parentController = controller
        }
      }
      .onAppear {
        hostView = UIHostingController(rootView: overlay)
      }
      .onChange(of: show) { newValue in
        if newValue {
          hostView = UIHostingController(rootView: overlay)
          if let hostView {
            hostView.modalPresentationStyle = .overCurrentContext
            hostView.modalTransitionStyle = .crossDissolve
            hostView.view.backgroundColor = .clear
            parentController?.present(hostView, animated: false)
          }
        } else {
          hostView?.dismiss(animated: false)
        }
      }
  }
}

struct ExtractSwiftUIParentController<Content: View>: UIViewRepresentable {
  var content: Content
  @Binding var hostView: UIHostingController<Content>?
  var parentController: (UIViewController?) -> Void

  func makeUIView(context: Context) -> some UIView {
    return UIView()
  }

  @MainActor
  func updateUIView(_ uiView: UIViewType, context: Context) {
    hostView?.rootView = content
    Task {
      parentController(uiView.superview?.parentController)
    }
  }
}

public extension UIView {
  var parentController: UIViewController? {
    var responder = self.next
    while responder != nil {
      if let viewController = responder as? UIViewController {
        return viewController
      }
      responder = responder?.next
    }
    return nil
  }
}

#elseif os(macOS)
struct BackgroundView<T: View>: NSViewRepresentable {
  @Binding var isVisible: Bool
  let frame: CGRect
  let content: T
  init(isVisible: Binding<Bool>, frame: CGRect, @ViewBuilder content: () -> T) {
    self._isVisible = isVisible
    self.frame = frame
    self.content = content()
  }

  func makeNSView(context: Context) -> NSView {
    return NSView()
  }

  func updateNSView(_ nsView: NSView, context: Context) {
    let popover = NSPopover()
    let content = NSHostingController(rootView: content)
    popover.contentViewController = content
    popover.setValue(true, forKeyPath: "shouldHideAnchor")
    popover.animates = false
    popover.behavior = .semitransient
    let rect = NSRect(x: nsView.bounds.width/2, y: 0, width: nsView.bounds.width, height: nsView.bounds.height)
    if isVisible {
      popover.show(relativeTo: rect, of: nsView, preferredEdge: .minY)
    }
  }
}
#endif
