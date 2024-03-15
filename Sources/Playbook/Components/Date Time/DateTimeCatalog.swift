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
        PBDoc(title: "Alignment") {
          alignmentView
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
        dateVariant: .dayDate(showYear: true),
        timeVariant: .iconTimeZone,
        isLowercase: true,
        isBold: true,
        timeZoneIdentifier: "EST"
      )
      PBDateTime(
        dateVariant: .dayDate(showYear: false),
        timeVariant: .iconTimeZone,
        isLowercase: true,
        isBold: true,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z"
      )
      PBDateTime(
        dateVariant: .short,
        timeVariant: .iconTimeZone,
        isLowercase: true,
        isBold: true,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z",
        showIcon: true
      )
      PBDateTime(
        dateVariant: .standard,
        timeVariant: .iconTimeZone,
        isLowercase: true,
        isBold: true,
        showTimeZone: true,
        timeZoneIdentifier: "GMT+9"
      )
    }
  }
  var alignmentView: some View {
    VStack(spacing: Spacing.small) {
      HStack {
        PBDateTime(
          dateVariant: .short,
          timeVariant: .iconTimeZone,
          isLowercase: true,
          isBold: true,
          zone: .utc,
          showTimeZone: true,
          timeZoneIdentifier: "2012-08-02T17:49:29Z"
        )
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      PBDateTime(
        dateVariant: .short,
        timeVariant: .iconTimeZone,
        isLowercase: true,
        isBold: true,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z"
      )
      HStack {
        PBDateTime(
          dateVariant: .short,
          timeVariant: .iconTimeZone,
          isLowercase: true,
          isBold: true,
          zone: .utc,
          showTimeZone: true,
          timeZoneIdentifier: "2012-08-02T17:49:29Z"
        )
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
}

