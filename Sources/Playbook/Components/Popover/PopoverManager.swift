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
    @Published var isPopooverActive: Bool = false

    public static let shared = PopoverManager()
    
    struct Popover {
        var view: AnyView
        var position: CGPoint?
        var close: (Close, action: (() -> Void)?) = (.anywhere, nil)
    }
    
    public var isPopoverActive: Bool {
        return isPopooverActive
    }
    
    func createPopover(with id: Int, view: AnyView, position: CGPoint?, close: (Close, action: (() -> Void)?)) {
        popovers[id] = Popover(view: view, position: position, close: close)
        isPresented[id] = false
    }
    
    func teardownPopover(with id: Int) {
        popovers[id] = nil
        isPresented[id] = nil
    }
    
    func presentPopover(with id: Int, value: Bool) {
        DispatchQueue.main.async {
            self.isPresented.updateValue(value, forKey: id)
            self.isPopooverActive = value
        }
    }
    
    func dismissPopover(with id: Int) {
        isPresented[id] = false
    }
    
    public func dismissPopovers() async {
        DispatchQueue.main.async {
            self.isPresented.keys.forEach {
                self.isPresented[$0] = false
            }
        }
    }
    
    func updatePopover(with id: Int, view: AnyView, position: CGPoint?) {
        if let popover = popovers.first(where: { $0.key == id })?.value, let position = position {
            let newPopover = Popover(view: view, position: position, close: popover.close)
            DispatchQueue.main.async {
                self.popovers.updateValue(newPopover, forKey: id)
            }
        }
    }
    
    func update(with id: Int) {
        if let popover = popovers.first(where: { $0.key == id })?.value {
            let newPopover = Popover(view: popover.view, position: popover.position, close: popover.close)
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
