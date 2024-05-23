//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverHandler.swift
//

import SwiftUI

struct PopoverHandler: ViewModifier {
  let popoverManager = PopoverManager.shared
  
  func body(content: Content) -> some View {
    content
      .overlay(
        GlobalPopoverView()
      )
      .environmentObject(popoverManager)
  }
}

public extension View {
  func popoverHandler() -> some View {
    self.modifier(PopoverHandler())
  }
}

struct GlobalPopoverView: View {
  @EnvironmentObject var popoverManager: PopoverManager
  
  var body: some View {
    ZStack {
      Color.clear
      let presentedList = popoverManager.isPresented.sorted(by: { $0.key <= $1.key} )
      ForEach(presentedList, id: \.key) { key, isPresented in
        if isPresented {
          ClickDetectorView {
            popoverManager.isPresented[key] = false
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.black.opacity(0.001)) // Make the view clickable but not visibly noticeable
        }
      }
      let list = popoverManager.popovers.sorted(by: { $0.key <= $1.key} )
      ForEach(list, id: \.key) { key, popover in
        popover.view
          .position(popover.position ?? .zero)
          .onTapGesture {
            popoverManager.isPresented[key] = false
          }
      }
    }
  }
  
  private func closeInside(_ key: Int) -> Void {
    switch popoverManager.close.0 {
    case .inside, .anywhere:
      popoverManager.popovers.removeValue(forKey: key)
      onClose(key)
    case .outside:
      break
    }
  }
  
  private func closeOutside() -> Void {
    switch popoverManager.close.0 {
    case .inside:
      break
    case .outside, .anywhere:
      popoverManager.popovers.removeValue(forKey: 0)
      onClose(0)
    }
  }
  
  private func onClose(_ key: Int) {
    if let closeAction = popoverManager.close.action {
      popoverManager.isPresented[key] = false
      closeAction()
    } else {
      popoverManager.isPresented[key] = false
    }
  }
}


#if os(iOS)
struct ClickDetectorView: UIViewRepresentable {
  var onTouch: () -> Void
  
  class Coordinator: NSObject {
    var onTouch: () -> Void
    
    init(onTouch: @escaping () -> Void) {
      self.onTouch = onTouch
    }
    
    @objc func handleTap() {
      onTouch()
    }
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(onTouch: onTouch)
  }
  
  func makeUIView(context: Context) -> UIView {
    let view = UIView(frame: .zero)
    let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap))
    view.addGestureRecognizer(tapGesture)
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {}
}
#elseif os(macOS)
struct ClickDetectorView: NSViewRepresentable {
  var onClick: () -> Void
  
  class Coordinator: NSObject {
    var onClick: () -> Void
    
    init(onClick: @escaping () -> Void) {
      self.onClick = onClick
    }
    
    @objc func handleClick() {
      onClick()
    }
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(onClick: onClick)
  }
  
  func makeNSView(context: Context) -> NSView {
    let view = NSView(frame: .zero)
    let clickGesture = NSClickGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleClick))
    view.addGestureRecognizer(clickGesture)
    return view
  }
  
  func updateNSView(_ nsView: NSView, context: Context) {}
}
#endif
