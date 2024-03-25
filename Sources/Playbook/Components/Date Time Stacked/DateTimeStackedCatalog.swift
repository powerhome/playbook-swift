//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  DateTimeStackedCatalog.swift
//

import SwiftUI

public struct DateTimeStackedCatalog: View {
    public var body: some View {
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Default") {
            defaultView
          }
        }
        .padding(Spacing.medium)
      }
      .background(Color.background(Color.BackgroundColor.light))
      .navigationTitle("Date Time Stacked")
    }
}

extension DateTimeStackedCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
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

