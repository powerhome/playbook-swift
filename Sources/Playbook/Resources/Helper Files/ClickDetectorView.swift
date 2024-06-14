//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ClickDetectorView.swift
//

import SwiftUI

#if os(iOS)
struct ClickDetectorView: UIViewRepresentable {
  var onClick: () -> Void
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(onClick: onClick)
  }
  
  func makeUIView(context: Context) -> UIView {
    let view = UIView(frame: .zero)
    let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleClick))
    view.addGestureRecognizer(tapGesture)
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {}
  
  class Coordinator: NSObject {
    var onClick: () -> Void
    
    init(onClick: @escaping () -> Void) {
      self.onClick = onClick
    }
    
    @objc func handleClick() {
      onClick()
    }
  }
}
#elseif os(macOS)
struct ClickDetectorView: NSViewRepresentable {
  var onClick: () -> Void
  
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
  
  class Coordinator: NSObject {
    var onClick: () -> Void
    
    init(onClick: @escaping () -> Void) {
      self.onClick = onClick
    }
    
    @objc func handleClick() {
      onClick()
    }
  }
}
#endif
