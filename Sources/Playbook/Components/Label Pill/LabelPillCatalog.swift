//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  LabelPillCatalog.swift
//

import SwiftUI

public struct LabelPillCatalog: View {
  public var body: some View {
    PBDocStack(title: "Label Pill", spacing: Spacing.xxSmall) {
      PBDoc(title: "Default") {
        defaultView
      }
    }
  }
}

extension LabelPillCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.xxSmall) {
      PBLabelPill(
        variant: .neutral,
        label: "Service Needed",
        pillValue: "76"
      )
      PBLabelPill(
        variant: .success,
        label: "Waiting",
        pillValue: "69"
      )
      PBLabelPill(
        variant: .error,
        label: "In Service",
        pillValue: "28"
      )
      PBLabelPill(
        variant: .warning,
        label: "Fully Serviced",
        pillValue: "101"
      )
      PBLabelPill(
        variant: .info,
        label: "Inbox",
        pillValue: "197"
      )
      PBLabelPill(
        variant: .neutral,
        label: "Outbox",
        pillValue: "13"
      )
      PBLabelPill(
        variant: .primary,
        label: "Inbox",
        pillValue: "218"
      )
    }
  }
}

#Preview {
  registerFonts()
  return LabelPillCatalog()
}
