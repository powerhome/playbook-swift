//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  DateRangeInlineCatalog.swift
//

import SwiftUI

public struct DateRangeInlineCatalog: View {
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
      .navigationTitle("Date Range Inline")
    }
}

extension DateRangeInlineCatalog {
  var defaultView: some View  {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateRangeInline(alignment: .leading, size: .caption, startDate: "18 Jun 2013", endDate: "20 Mar 2015", variant: .standard)
    }
  }
}
