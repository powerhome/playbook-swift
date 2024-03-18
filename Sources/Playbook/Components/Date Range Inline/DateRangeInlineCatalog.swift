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
    VStack(alignment: .leading, spacing: Spacing.medium) {
      VStack(spacing: Spacing.small) {
        PBDateRangeInline(size: .caption, startDate: "18 Jun 2013", endDate: "20 Mar 2015", startVariant: .standard)
        PBDateRangeInline(size: .body, startDate: "18 Jun 2013", endDate: "20 Mar 2015", startVariant: .standard)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      VStack(spacing: Spacing.small) {
        PBDateRangeInline(alignment: .center, size: .caption, startDate: "18 Jun 2013", endDate: "20 Mar 2015", startVariant: .short(showIcon: true), endVariant: .short(showIcon: false))
        PBDateRangeInline(alignment: .center, size: .body, startDate: "18 Jun 2013", endDate: "20 Mar 2015", startVariant: .short(showIcon: true), endVariant: .short(showIcon: false))
      }
      .frame(maxWidth: .infinity, alignment: .center)
      
      VStack(spacing: Spacing.small) {
        PBDateRangeInline(alignment: .center, size: .caption, startDate: "18 Jun 2013", endDate: "20 Mar 2015", startVariant: .short(showIcon: true), endVariant: .short(showIcon: false))
        PBDateRangeInline(alignment: .center, size: .body, startDate: "18 Jun 2013", endDate: "20 Mar 2015", startVariant: .short(showIcon: true), endVariant: .short(showIcon: false))
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
      
    }
  }
}
