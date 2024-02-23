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
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBTimeRangeInline(
        alignment: .leading,
        startTime: "MST",
        endTime: "EST",
        size: .caption
      )
      PBTimeRangeInline(
        alignment: .leading,
        startTime: "MST",
        endTime: "EST",
        size: .body,
        isTimeBold: true,
        isArrowIconBold: false,
        isLowercase: true
      )
    }
  }
}
