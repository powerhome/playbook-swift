//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  IconStatValueCatalog.swift
//

import SwiftUI

public struct IconStatValueCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          defaultView
        }
        
        PBDoc(title: "Size") {
          sizeView
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(.default))
    .navigationTitle("Icon Stat Value")
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
        value: "158.3",
        unit: "mi",
        text: "distance driven"
      )
      PBIconStatValue(
        icon: .car,
        iconSize: .large,
        value: "158.3",
        unit:  "mi",
        text: "distance driven",
        valueFontSize: .title2,
        unitBaselineOffset: -7
      )
      PBIconStatValue(
        icon: .car,
        iconSize: .x2,
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
