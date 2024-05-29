//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PillCatalog.swift
//

import SwiftUI

public struct PillCatalog: View {
  public var body: some View {
    PBDocStack(title: "Pill") {
      PBDoc(title: "Default") {
        defaultView
      }

      PBDoc(title: "Variants") {
        variantsView
      }
    }
  }
}

extension PillCatalog {
  var defaultView: some View {
    PBPill("default")
  }
  var variantsView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBPill("success", variant: .success)
      PBPill("error", variant: .error)
      PBPill("warning", variant: .warning)
      PBPill("info", variant: .info)
      PBPill("neutral", variant: .neutral)
      PBPill("primary", variant: .primary)
    }
  }
}
