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
  // Return true if the event should be consumed (override default behavior)
  func onKeyPress(_ key: KeyCode) -> Bool
}

enum KeyCode {
  case tab
  case `return`
  case downArrow
  case upArrow
  case space
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
      return delegate.onKeyPress(.tab) ? nil : event
      
    case 36: // return/enter
        return delegate.onKeyPress(.return) ? nil : event

    case 125: // down arrow
        delegate.onKeyPress(.downArrow)
        return event

    case 126: // up arrow
        delegate.onKeyPress(.upArrow)
        return event

    case 49: // space
      return delegate.onKeyPress(.space) ? nil : event

    case 53: // escape
      return delegate.onKeyPress(.escape) ? nil : event
      
    case 51: // backspace
        return delegate.onKeyPress(.backspace) ? nil : event

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
