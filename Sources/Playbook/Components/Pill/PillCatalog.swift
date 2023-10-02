//
//  PillCatalog.swift
//
//
//  Created by Israel Molestina on 5/18/23.
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
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Pill")
  }
}
