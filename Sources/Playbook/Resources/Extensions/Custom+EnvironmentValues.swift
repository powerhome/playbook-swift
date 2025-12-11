//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Custom+EnvironmentValues.swift
//

import SwiftUI

struct Selection: EnvironmentKey {
  static let defaultValue = false
}

struct Hovering: EnvironmentKey {
  static let defaultValue = false
}

struct Active: EnvironmentKey {
  static let defaultValue = false
}

struct Focus: EnvironmentKey {
  static let defaultValue = false
}

struct PBNavVariant: EnvironmentKey {
  static let defaultValue = PBNav.Variant.normal
}

struct PBNavOrientation: EnvironmentKey {
  static let defaultValue = Orientation.vertical
}

struct PBNavHighlight: EnvironmentKey {
  static let defaultValue = true
}

struct NavSelectionHandlerKey: EnvironmentKey {
  static let defaultValue: (() -> Void)? = nil
}

public extension EnvironmentValues {
  var selected: Bool {
    get { self[Selection.self] }
    set { self[Selection.self] = newValue }
  }

  var hovering: Bool {
    get { self[Hovering.self] }
    set { self[Hovering.self] = newValue }
  }

  var active: Bool {
    get { self[Active.self] }
    set { self[Active.self] = newValue }
  }

  var focus: Bool {
    get { self[Focus.self] }
    set { self[Focus.self] = newValue }
  }

  var variant: PBNav.Variant {
    get { self[PBNavVariant.self] }
    set { self[PBNavVariant.self] = newValue }
  }

  var orientation: Orientation {
    get { self[PBNavOrientation.self] }
    set { self[PBNavOrientation.self] = newValue }
  }

  var highlight: Bool {
    get { self[PBNavHighlight.self] }
    set { self[PBNavHighlight.self] = newValue }
  }

  var navSelectionHandler: (() -> Void)? {
    get { self[NavSelectionHandlerKey.self] }
    set { self[NavSelectionHandlerKey.self] = newValue }
  }
}
