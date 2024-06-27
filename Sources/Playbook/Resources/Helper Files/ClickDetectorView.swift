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
    
    func makeUIView(context: Context) -> UIView {
        let view = ClickableUIView(onClick: onClick)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

class ClickableUIView: UIView {
    var onClick: () -> Void
    
    init(onClick: @escaping () -> Void) {
        self.onClick = onClick
        super.init(frame: .zero)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleClick))
        self.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleClick() {
        self.window?.endEditing(true)
        onClick()
    }
}

#elseif os(macOS)
import SwiftUI

struct ClickDetectorView: NSViewRepresentable {
    var onClick: () -> Void
    
    func makeNSView(context: Context) -> NSView {
        let view = ClickableNSView(onClick: onClick)
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
}

class ClickableNSView: NSView {
    var onClick: () -> Void
    
    init(onClick: @escaping () -> Void) {
        self.onClick = onClick
        super.init(frame: .zero)
        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClick))
        self.addGestureRecognizer(clickGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleClick() {
        if let window = self.window {
            window.makeFirstResponder(nil)
        }
        onClick()
    }
}
#endif
