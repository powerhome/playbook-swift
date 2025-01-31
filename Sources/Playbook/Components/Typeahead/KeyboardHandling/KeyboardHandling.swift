//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTypeahead.swift
//

#if os(macOS)
import Foundation

enum KeyCode {
  static let tab = UInt16(48)
  static let `return` = UInt16(36)
  static let downArrow = UInt16(125)
  static let upArrow = UInt16(126)
  static let escape = UInt16(53)
}

protocol KeyboardHandling: AnyObject {
    func setupKeyboardMonitoring()
    func cleanup()
    func handleKeyEvent(_ event: NSEvent)
}

enum KeyboardHandlingError: Error {
    case viewModelNil
    case indexOutOfBounds
    case invalidSelection
    
    var localizedDescription: String {
        switch self {
        case .viewModelNil:
            return "ViewModel reference is nil"
        case .indexOutOfBounds:
            return "Selected index is out of bounds"
        case .invalidSelection:
            return "Invalid selection state"
        }
    }
}
#endif 
