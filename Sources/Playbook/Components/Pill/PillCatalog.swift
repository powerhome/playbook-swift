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
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          PBPill("default")
        }

        PBDoc(title: "Variants") {
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
      .padding(Spacing.medium)
    }
    .navigationTitle("Pill")
  }
}
