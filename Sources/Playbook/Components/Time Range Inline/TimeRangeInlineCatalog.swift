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
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Default") {
            defaultView
          }
        }
        .padding(Spacing.medium)
      }
      .background(Color.background(.light))
      .navigationTitle("Time Range Inline")
    }
}

extension TimeRangeInlineCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.large) {
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
      Spacer()
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
        showStartTimeZone: false,
        startVariant: .clockIcon
        
      )
      PBTimeRangeInline(
        size: .body,
        startTime: "2012-08-02T15:49:29Z",
        endTime: "2012-08-02T17:49:29Z",
        isTimeBold: true,
        isLowercase: true,
        startVariant: .clockIcon
      )
      Spacer()
      PBTimeRangeInline(
        size: .caption,
        startTime: "2012-08-02T15:49:29Z",
        endTime: "2012-08-02T17:49:29Z",
        showIcon: true,
        showEndTimeZone: true,
        startVariant: .clockIcon
      )
      PBTimeRangeInline(
        size: .body,
        startTime: "2012-08-02T15:49:29Z",
        endTime: "2012-08-02T17:49:29Z",
        showIcon: true,
        showEndTimeZone: true,
        isTimeBold: true,
        isTimeZoneBold: false,
        startVariant: .clockIcon
      )
      Spacer()
    }
  }
}
