//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  DateStackedCatalog.swift
//

import SwiftUI

public struct DateStackedCatalog: View {
    public var body: some View {
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Default") {
            defaultView
          }
          PBDoc(title: "Not Current Year") {
            notCurrentYearView
          }
          PBDoc(title: "Day & Month Reverse") {
            dayMonthReversedView
          }
          PBDoc(title: "Sizes") {
            sizesView
          }
          PBDoc(title: "Bold") {
            boldView
          }
        }
        .padding(Spacing.medium)
      }
      .background(Color.background(Color.BackgroundColor.light))
      .navigationTitle("Date Stacked")
    }
}

extension DateStackedCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateStacked(
        date: Date(),
        variant: .short(showIcon: false),
        dateSize: .title4,
        isMonthStacked: true
      )
      PBDateStacked(
        date: Date(),
        variant: .short(showIcon: false),
        dateSize: .title3,
        isMonthStacked: true
      )
    }
  }
  var notCurrentYearView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateStacked(
        alignment: .leading,
        date: Date().makeDate(year: 2018, month: 3, day: 20),
        variant: .standard,
        dateSize: .title4,
        isStandardStacked: true
      )
      PBDateStacked(
        alignment: .leading,
        date: Date().makeDate(year: 2018, month: 3, day: 20),
        variant: .standard,
        dateSize: .title3,
        isStandardStacked: true
      )
    }
  }
  var dayMonthReversedView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateStacked(
        date: Date(),
        variant: .short(showIcon: false),
        dateSize: .title4,
        isReversed: true
      )
      PBDateStacked(
        date: Date(),
        variant: .short(showIcon: false),
        dateSize: .title3,
        isReversed: true
      )
    }
  }
  var sizesView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateStacked(
        date: Date(),
        variant: .short(showIcon: false),
        dateSize: .title4,
        isMonthStacked: true
      )
      PBDateStacked(
        date: Date(),
        variant: .short(showIcon: false),
        dateSize: .title3,
        isMonthStacked: true
      )
    }
  }
  var boldView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
        PBDateStacked(
          alignment: .leading,
          date: Date(),
          variant: .short(showIcon: false),
          dateSize: .title4,
          isMonthStacked: true,
          isMonthBold: true
        )
        PBDateStacked(
          alignment: .center,
          date: Date().makeDate(year: 2018, month: 3, day: 20),
          variant: .standard,
          dateSize: .title4,
          isStandardStacked: true,
          isYearBold: true,
          isMonthBold: true
        )
        .frame(maxWidth: .infinity, alignment: .center)
        PBDateStacked(
          alignment: .trailing, 
          date: Date(),
          variant: .short(showIcon: false),
          dateSize: .title4,
          isMonthStacked: true,
          isMonthBold: true
        )
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
}

