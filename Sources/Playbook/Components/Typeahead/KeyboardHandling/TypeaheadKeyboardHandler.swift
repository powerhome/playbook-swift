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

protocol TypeaheadKeyboardDelegate: AnyObject {
  func onKeyPress(_ key: KeyCode)
}

enum KeyCode {
  case tab
  case `return`
  case downArrow
  case upArrow
  case escape
  case backspace
}

final class TypeaheadKeyboardHandler: ObservableObject {
  weak var delegate: TypeaheadKeyboardDelegate? {
    didSet {
      setupKeyboardMonitoring()
    }
  }
  private var localMonitor: Any?
  
  func setupKeyboardMonitoring() {
    localMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
      self?.handleKeyEvent(event)
    }
  }
  
  func handleKeyEvent(_ event: NSEvent) -> NSEvent? {
    guard let delegate else { return event }
    
    switch event.keyCode {
    case 48: // tab
      delegate.onKeyPress(.tab)
      return event // Allow tab to perform its default behavior
      
    case 36: // return/enter
      delegate.onKeyPress(.return)
      return nil // Consume the event
      
    case 125: // down arrow
      delegate.onKeyPress(.downArrow)
      return nil // Consume the event
      
    case 126: // up arrow
      delegate.onKeyPress(.upArrow)
      return nil // Consume the event
      
    case 53: // escape
      delegate.onKeyPress(.escape)
      return nil // Consume the event
      
    case 51: // backspace
      delegate.onKeyPress(.backspace)
      return event // Allow backspace to perform its default behavior

    default:
      return event
    }
  }
  
  func cleanup() {
    if let monitor = localMonitor {
      NSEvent.removeMonitor(monitor)
      localMonitor = nil
    }
  }
}
#endif 
