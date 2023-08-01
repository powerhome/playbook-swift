//
//  Custom+EnvironmentValues.swift
//  
//
//  Created by Isis Silva on 14/07/23.
//

import SwiftUI

struct PBNavSelection: EnvironmentKey {
  static let defaultValue = false
}

struct PBNavHovering: EnvironmentKey {
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

public extension EnvironmentValues {
  var selected: Bool {
    get { self[PBNavSelection.self] }
    set { self[PBNavSelection.self] = newValue }
  }

  var hovering: Bool {
    get { self[PBNavHovering.self] }
    set { self[PBNavHovering.self] = newValue }
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
}
