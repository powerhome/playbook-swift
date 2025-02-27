//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  DateRangeStackedCatalog.swift
//

import SwiftUI
import Playbook

public struct DateRangeStackedCatalog: View {
  public var body: some View {
    PBDocStack(title: "Date Range Stacked") {
      PBDoc(title: "Default") {
        defaultView
      }
    }
  }
}

extension DateRangeStackedCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateRangeStacked(
        startDate: Date().makeDate(year: 2019, month: 6, day: 18),
        endDate: Date().makeDate(year: 2020, month: 3, day: 20),
        startAlignment: .trailing,
        endAlignment: .leading,
        startVariant: .short(showIcon: false),
        endVariant: .short(showIcon: false)
      )
    }
  }
}

