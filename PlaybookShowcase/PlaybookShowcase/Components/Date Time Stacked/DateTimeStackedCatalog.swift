//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  DateTimeStackedCatalog.swift
//

import SwiftUI
import Playbook

public struct DateTimeStackedCatalog: View {
  public var body: some View {
    PBDocStack(title: "Date Time Stacked") {
      PBDoc(title: "Default") {
        defaultView
      }
    }
  }
}

extension DateTimeStackedCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateTimeStacked(
        timeZoneIdentifier: "EDT",
        isLowercase: true,
        isMonthStacked: true,
        isMonthBold: true
      )
      PBDateTimeStacked(
        timeZoneIdentifier: "EDT",
        isYearDisplayed: true,
        isLowercase: true,
        isMonthStacked: true,
        isMonthBold: true,
        isYearBold: true,
        dateVariant: .standard
      )
      PBDateTimeStacked(
        timeZoneIdentifier: "GMT+9",
        isLowercase: true,
        isMonthStacked: true,
        isMonthBold: true
      )
      PBDateTimeStacked(
        timeZoneIdentifier: "MDT",
        isLowercase: true,
        isMonthStacked: true,
        isMonthBold: true
      )
    }
  }
}
