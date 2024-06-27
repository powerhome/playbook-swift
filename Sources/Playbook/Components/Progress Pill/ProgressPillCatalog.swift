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
  @State private var active: Int = 2
  @State private var active1: Int = 2
  public var body: some View {
    PBDocStack(title: "Progress Pill", spacing: Spacing.medium) {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Status") {
        statusView
      }
    }
  }
}

extension ProgressPillCatalog {
  var defaultView: some View {
    VStack(alignment: .leading) {
      PBProgressPill(
        active: $active
      )
    }
  }
  var statusView: some View {
    VStack(alignment: .leading) {
      PBProgressPill(
        active: $active1,
        title: "Status:",
        value: "Orientation"
      )
    }
  }
}

#Preview {
  registerFonts()
  return ProgressPillCatalog()
}
