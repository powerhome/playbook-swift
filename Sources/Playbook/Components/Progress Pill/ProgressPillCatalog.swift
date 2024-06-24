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
  @State private var active: Int = 2
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
    VStack(alignment: .leading) {
      PBProgressPill(
        isActive: $isActive,
        active: $active
      )
    }
  }
}

#Preview {
  registerFonts()
  return ProgressPillCatalog()
}
