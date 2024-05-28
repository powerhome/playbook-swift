//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  TimeRangeInlineCatalog.swift
//

import SwiftUI

public struct TimeRangeInlineCatalog: View {
    public var body: some View {
      PBDocStack(title: "Time Range Inline") {
        PBDoc(title: "Default") {
          defaultView
        }
      }
    }
}

extension TimeRangeInlineCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      VStack(spacing: Spacing.medium) {
        PBTimeRangeInline(
          size: .caption,
          startTime: "2012-08-02T15:49:29Z",
          endTime: "2012-08-02T17:49:29Z"
        )
        PBTimeRangeInline(
          size: .body,
          startTime: "2012-08-02T15:49:29Z",
          endTime: "2012-08-02T17:49:29Z",
          isTimeBold: true,
          isLowercase: true
        )
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      Spacer()
      VStack(spacing: Spacing.medium) {
        PBTimeRangeInline(
          size: .caption,
          startTime: "2012-08-02T15:49:29Z",
          endTime: "2012-08-02T17:49:29Z",
          showEndTimeZone: true
        )
        PBTimeRangeInline(
          size: .body,
          startTime: "2012-08-02T15:49:29Z",
          endTime: "2012-08-02T17:49:29Z",
          showEndTimeZone: true,
          isTimeBold: true,
          isTimeZoneBold: false,
          isLowercase: true
        )
      Spacer()
        PBTimeRangeInline(
          size: .caption,
          startTime: "2012-08-02T15:49:29Z",
          endTime: "2012-08-02T17:49:29Z",
          startVariant: .showIconTime
        )
        PBTimeRangeInline(
          size: .body,
          startTime: "2012-08-02T15:49:29Z",
          endTime: "2012-08-02T17:49:29Z",
          showEndTimeZone: false, isTimeBold: true,
          isLowercase: true,
          startVariant: .showIconTime
        )
      }
      .frame(maxWidth: .infinity, alignment: .center)
      Spacer()
      VStack(spacing: Spacing.medium) {
        PBTimeRangeInline(
          size: .caption,
          startTime: "2012-08-02T15:49:29Z",
          endTime: "2012-08-02T17:49:29Z",
          showIcon: true,
          showEndTimeZone: true,
          startVariant: .showIconTime
        )
        PBTimeRangeInline(
          size: .body,
          startTime: "2012-08-02T15:49:29Z",
          endTime: "2012-08-02T17:49:29Z",
          showIcon: true,
          showEndTimeZone: true,
          isTimeBold: true,
          isTimeZoneBold: false,
          startVariant: .showIconTime
        )
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
      Spacer()
    }
  }
}
