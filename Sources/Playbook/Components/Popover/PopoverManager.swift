//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PopoverManager.swift
//

import SwiftUI

public class PopoverManager: ObservableObject {
    @Published var isPresented: [Int : Bool] = [:]
    @Published var popovers: [Int : Popover] = [:]
    
    public static let shared = PopoverManager()
    
    struct Popover {
        var view: AnyView
        var position: CGPoint?
        var close: (Close, action: (() -> Void)?) = (.anywhere, nil)
    }
    
    func createPopover(with id: Int, view: AnyView, position: CGPoint?, close: (Close, action: (() -> Void)?)) {
        popovers[id] = Popover(view: view, position: position, close: close)
        isPresented[id] = false
    }
    
    func removeValues() {
        popovers.removeAll()
        isPresented.removeAll()
    }
    
    func presentPopover(with id: Int, value: Bool) {
        isPresented.updateValue(value, forKey: id)
    }
    
    private func dismissPopover(with id: Int) {
        isPresented[id] = false
    }
    
    func updatePopover(with id: Int, view: AnyView, position: CGPoint?) {
        if let popover = popovers.first(where: { $0.key == id })?.value, let position = position {
            let newPopover = Popover(view: view, position: position, close: popover.close)
            popovers.updateValue(newPopover, forKey: id)
        }
    }
    
    func closeInside(_ key: Int) -> Void {
        switch popovers[key]?.close.0 {
            case .inside, .anywhere:
                onClose(key)
            default:
                break
        }
    }

    func closeOutside(_ key: Int) {
        switch popovers[key]?.close.0 {
            case .outside, .anywhere:
                onClose(key)
            default:
                break
        }
    }
    
    func closeOutside() {
        _ = popovers.map { key, popover in
            switch popover.close.0 {
                case .outside, .anywhere:
                    onClose(key)
                default:
                    break
            }
        }
    }
    
    private func onClose(_ key: Int) {
        if let closeAction = popovers[key]?.close.action {
            closeAction()
        }
        dismissPopover(with: key)
    }
    
    public enum Close {
        case inside, outside, anywhere
    }
}
