//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Playbook.swift
//

import SwiftUI

/// Exposes this Swift Package's bundle to the user.
public let playbookBundle = Bundle.module

#if os(macOS)
  /// Hides all NSTextField's focusRings.
  extension NSTextField {
    override open var focusRingType: NSFocusRingType {
      get { .none }
      set {}
    }
  }
#endif
