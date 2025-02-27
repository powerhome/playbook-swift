//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  DateTimeCatalog.swift
//

import SwiftUI
import Playbook

public struct DateTimeCatalog: View {
  public var body: some View {
    PBDocStack(title: "Date Time") {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Alignment") {
        alignmentView
      }
      PBDoc(title: "Size") {
        sizeView
      }
    }
  }
}

extension DateTimeCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBDateTime(
        dateVariant: .dayDate(showYear: true),
        timeVariant: .iconTimeZone,
        timeFontSize: .body,
        isLowercase: true,
        isTimeBold: true,
        timeZoneIdentifier: "EST",
        dateFontSize: .title4
      )
      PBDateTime(
        dateVariant: .dayDate(showYear: false),
        timeVariant: .iconTimeZone,
        timeFontSize: .body,
        isLowercase: true,
        isTimeBold: true,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z"
      )
      PBDateTime(
        dateVariant: .short(showIcon: false),
        timeVariant: .iconTimeZone,
        isLowercase: true,
        isTimeBold: true,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z",
        dateFontSize: .title4
      )
      PBDateTime(
        dateVariant: .short(showIcon: false),
        timeVariant: .iconTimeZone,
        timeFontSize: .body,
        isLowercase: true,
        isTimeBold: true,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z",
        showIcon: true,
        dateFontSize: .title4
      )
      PBDateTime(
        dateVariant: .standard,
        timeVariant: .iconTimeZone,
        timeFontSize: .body,
        isLowercase: true,
        isTimeBold: true,
        showTimeZone: true,
        timeZoneIdentifier: "GMT+9",
        dateFontSize: .title4
      )
    }
  }
  var alignmentView: some View {
    VStack(spacing: Spacing.medium) {
      HStack {
        PBDateTime(
          dateVariant: .short(showIcon: false),
          timeVariant: .iconTimeZone,
          timeFontSize: .body,
          isLowercase: true,
          isTimeBold: true,
          zone: .utc,
          showTimeZone: true,
          timeZoneIdentifier: "2012-08-02T17:49:29Z",
          dateFontSize: .title4
        )
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      PBDateTime(
        dateVariant: .short(showIcon: false),
        timeVariant: .iconTimeZone,
        timeFontSize: .body,
        isLowercase: true,
        isTimeBold: true,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z"
      )
      HStack {
        PBDateTime(
          dateVariant: .short(showIcon: false),
          timeVariant: .iconTimeZone,
          timeFontSize: .body,
          isLowercase: true,
          isTimeBold: true,
          zone: .utc,
          showTimeZone: true,
          timeZoneIdentifier: "2012-08-02T17:49:29Z"
        )
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
  var sizeView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBDateTime(
        dateVariant: .dayDate(showYear: false), 
        timeVariant: .iconTimeZone,
        timeFontSize: .caption,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z",
        showIcon: true,
        dateFontSize: .caption
      )
      PBDateTime(
        dateVariant: .dayDate(showYear: false),
        timeVariant: .iconTimeZone,
        timeFontSize: .caption,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z",
        dateFontSize: .caption
      )
      PBDateTime(
        dateVariant: .short(showIcon: false),
        timeVariant: .iconTimeZone,
        timeFontSize: .caption,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z",
        showIcon: true,
        dateFontSize: .caption
      )
      PBDateTime(
        dateVariant: .short(showIcon: false),
        timeVariant: .iconTimeZone,
        timeFontSize: .caption,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z",
        dateFontSize: .caption
      )
      Spacer()
      PBDateTime(
        dateVariant: .dayDate(showYear: false),
        timeVariant: .iconTimeZone,
        isLowercase: true,
        isTimeBold: true,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z",
        showIcon: true
      )
      PBDateTime(
        dateVariant: .dayDate(showYear: false),
        timeVariant: .iconTimeZone,
        isLowercase: true,
        isTimeBold: true,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z"
      )
      PBDateTime(
        dateVariant: .short(showIcon: false),
        timeVariant: .iconTimeZone,
        isLowercase: true,
        isTimeBold: true,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z",
        showIcon: true
      )
      PBDateTime(
        dateVariant: .short(showIcon: false),
        timeVariant: .iconTimeZone,
        isLowercase: true,
        isTimeBold: true,
        zone: .utc,
        showTimeZone: true,
        timeZoneIdentifier: "2012-08-02T17:49:29Z"
      )
    }
  }
}

