//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ProgressPillCatalog.swift
//

import SwiftUI

public struct ProgressPillCatalog: View {
  @State private var isActive: Bool = true
  @State private var isActive1: Bool = true
  @State private var isActive2: Bool = false
  public var body: some View {
    PBDocStack(title: "Progress Pill", spacing: Spacing.medium) {
      PBDoc(title: "Default") {
        defaultView
      }
    }
  }
}

extension ProgressPillCatalog {
  var defaultView: some View {
    HStack {
      PBProgressPill(isActive: $isActive)
      PBProgressPill(isActive: $isActive1)
      PBProgressPill(isActive: $isActive2)
    }
  }
}

#Preview {
  registerFonts()
  return ProgressPillCatalog()
}
