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
    VStack(spacing: Spacing.large) {
      PBTimeRangeInline(
        alignment: .leading,
        size: .caption, startTime: "MST",
        endTime: "EST",
        startVariant: .time
      )
      PBTimeRangeInline(
        alignment: .leading,
        size: .body, startTime: "MST",
        endTime: "EST",
        showIcon: false,
        isTimeBold: true,
        isLowercase: true,
        startVariant: .time
      )
      Spacer()
        PBTimeRangeInline(
          alignment: .center,
          size: .caption, startTime: "MST",
          endTime: "EDT",
          showTimeZone: true,
          endVariant: .timeZone
        )
        PBTimeRangeInline(
          alignment: .center,
          size: .body,
          startTime: "MST",
          endTime: "EDT",
          showTimeZone: true,
          isTimeBold: true,
          isTimeZoneBold: false,
          isLowercase: true,
          endVariant: .timeZone
        )
      Spacer()
        PBTimeRangeInline(
          alignment: .center,
          size: .caption, startTime: "MST",
          endTime: "EST",
          showIcon: true,
          startVariant: .clockIcon
          
        )
        PBTimeRangeInline(
          alignment: .center,
          size: .body, startTime: "MST",
          endTime: "EST",
          showIcon: true,
          isTimeBold: true,
          isLowercase: true,
          startVariant: .clockIcon
        )
      Spacer()
        PBTimeRangeInline(
          alignment: .trailing,
          size: .caption, 
          startTime: "MST",
          endTime: "EDT",
          showIcon: true,
          showTimeZone: true,
          startVariant: .clockIcon,
          endVariant: .timeZone
        )
        PBTimeRangeInline(
          alignment: .trailing,
          size: .body, 
          startTime: "MST",
          endTime: "EDT",
          showIcon: true,
          showTimeZone: true,
          isTimeBold: true,
          isTimeZoneBold: false,
          isLowercase: true,
          startVariant: .clockIcon,
          endVariant: .timeZone
        )
      Spacer()
    }
  }
}
