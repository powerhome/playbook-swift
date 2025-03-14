//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  IconStatValueCatalog.swift
//

import SwiftUI
import Playbook

public struct IconStatValueCatalog: View {
  public var body: some View {
    PBDocStack(title: "Icon Stat Value", spacing: Spacing.medium, padding: Spacing.medium) {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Size") {
        sizeView
      }
    }
  }
}

extension IconStatValueCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBIconStatValue(
        value: "64.18",
        unit: "kw",
        text: "electric"
      )
      PBIconStatValue(
        icon: .calendar,
        value: "24",
        unit: "days",
        text: "deadline"
      )
    }
  }
  var sizeView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBIconStatValue(
        icon: .car,
        iconSize: .small,
        value: "158.3",
        unit: "mi",
        text: "distance driven"
      )
      PBIconStatValue(
        icon: .car,
        iconSize: .medium,
        value: "158.3",
        unit:  "mi",
        text: "distance driven",
        valueFontSize: .title2,
        unitBaselineOffset: -7
      )
      PBIconStatValue(
        icon: .car,
        iconSize: .large,
        value: "158.3",
        unit:  "mi",
        text: "distance driven",
        valueFontSize: .title1,
        unitBaselineOffset: -14
      )
    }
  }
}

#Preview {
  registerFonts()
  return IconStatValueCatalog()
}
