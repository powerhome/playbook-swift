//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  DateTimeCatalog.swift
//

import SwiftUI

public struct DateTimeCatalog: View {
    public var body: some View {
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Default") {
            defaultView
          }
        }
        .padding(Spacing.medium)
      }
      .background(Color.background(.light))
      .navigationTitle("Date Time")
    }
}

extension DateTimeCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateTime(
        iconSize: .x3,
        dateVariant: .dayDate(showYear: true),
        timeVariant: .iconTimeZone,
        fontSize: .body,
        isLowercase: true,
        isBold: true,
        timeZoneIdentifier: "EST"
      )
      PBDateTime(
        iconSize: .x3,
        dateVariant: .dayDate(showYear: false),
        timeVariant: .iconTimeZone,
        fontSize: .body,
        isLowercase: true,
        isBold: true,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z"
      )
      PBDateTime(
        iconSize: .x3,
        dateVariant: .short,
        timeVariant: .iconTimeZone,
        fontSize: .body,
        isLowercase: true,
        isBold: true,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z",
        showIcon: true
      )
      PBDateTime(
        iconSize: .x3,
        dateVariant: .standard,
        timeVariant: .iconTimeZone,
        fontSize: .body,
        isLowercase: true,
        isBold: true,
        showTimeZone: true,
        timeZoneIdentifier: "GMT+9"
      )
    }
  }
}

