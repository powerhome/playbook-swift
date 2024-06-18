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
        labelValue: "Service Needed",
        pillValue: "76",
        labelFontSize: .caption
      )
      PBLabelPill(
        variant: .success,
        labelValue: "Waiting",
        pillValue: "69",
        labelFontSize: .caption
      )
      PBLabelPill(
        variant: .error,
        labelValue: "In Service",
        pillValue: "28",
        labelFontSize: .caption,
        labelColor: .text(.light)
      )
      PBLabelPill(
        variant: .warning,
        labelValue: "Fully Serviced",
        pillValue: "101",
        labelFontSize: .caption,
        labelColor: .text(.light)
      )
      PBLabelPill(
        variant: .info,
        labelValue: "Inbox",
        pillValue: "197",
        labelFontSize: .caption,
        labelColor: .text(.light)
      )
      PBLabelPill(
        variant: .neutral,
        labelValue: "Outbox",
        pillValue: "13",
        labelFontSize: .caption,
        labelColor: .text(.light)
      )
      PBLabelPill(
        variant: .primary,
        labelValue: "Inbox",
        pillValue: "218",
        labelFontSize: .caption,
        labelColor: .text(.light)
      )
    }
  }
}

#Preview {
  registerFonts()
  return LabelPillCatalog()
}
