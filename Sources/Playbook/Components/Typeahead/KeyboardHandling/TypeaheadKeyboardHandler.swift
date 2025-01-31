//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTypeahead.swift
//

#if os(macOS)
import AppKit
import SwiftUI

final class TypeaheadKeyboardHandler {
    private weak var viewModel: PBTypeaheadViewModel?
    private var isFocused: Binding<Bool>
    private var localMonitor: Any?
    
    init(
        viewModel: PBTypeaheadViewModel,
        isFocused: Binding<Bool>
    ) {
        self.viewModel = viewModel
        self.isFocused = isFocused
    }
    
    deinit {
        cleanup()
    }
    
    func setupKeyboardMonitoring() {
        localMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            self?.handleKeyEvent(event)
            return event
        }
    }
    
    func cleanup() {
        if let monitor = localMonitor {
            NSEvent.removeMonitor(monitor)
            localMonitor = nil
        }
    }
    
    private func handleKeyEvent(_ event: NSEvent) {
        guard let viewModel else {
            return
        }
        
        switch event.keyCode {
        case KeyCode.tab:
            viewModel.focused = true
        case KeyCode.return:
            handleReturnKey()
        case KeyCode.downArrow:
            handleDownArrow()
        case KeyCode.upArrow:
            handleUpArrow()
        case KeyCode.escape:
            handleEscape()
        default:
            break
        }
    }
    
    // MARK: - Key Handler Methods
    
    private func handleReturnKey() {
        guard let viewModel = viewModel,
              viewModel.isFocused,
              let index = viewModel.hoveringIndex,
              index <= viewModel.searchResults.count - 1 else {
            return
        }
        
        viewModel.onListSelection(index: index, option: viewModel.searchResults[index])
    }
    
    private func handleDownArrow() {
        guard let viewModel = viewModel else { return }
        let currentIndex = viewModel.hoveringIndex ?? -1
        let nextIndex = min(currentIndex + 1, viewModel.searchResults.count - 1)
        viewModel.hoveringIndex = nextIndex
    }
    
    private func handleUpArrow() {
        guard let viewModel = viewModel else { return }
        let currentIndex = viewModel.hoveringIndex ?? 0
        let nextIndex = max(currentIndex - 1, 0)
        viewModel.hoveringIndex = nextIndex
    }
    
    private func handleEscape() {
        guard let viewModel = viewModel else { return }
        viewModel.showPopover = false
        isFocused.wrappedValue = false
    }
}
#endif 
