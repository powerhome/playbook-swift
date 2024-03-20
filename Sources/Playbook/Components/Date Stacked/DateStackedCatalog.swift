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
        dateStamp: Date(),
        variant: .short(showIcon: false),
        fontSize: .title4,
        isMonthStacked: true
      )
      PBDateStacked(
        dateStamp: Date(),
        variant: .short(showIcon: false),
        fontSize: .title3,
        isMonthStacked: true
      )
    }
  }
  var notCurrentYearView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateStacked(
        alignment: .leading,
        dateStamp: Date().makeDate(year: 2018, month: 3, day: 20),
        variant: .standard,
        fontSize: .title4,
        isStandardStacked: true
      )
      PBDateStacked(
        alignment: .leading,
        dateStamp: Date().makeDate(year: 2018, month: 3, day: 20),
        variant: .standard,
        fontSize: .title3,
        isStandardStacked: true
      )
    }
  }
  var dayMonthReversedView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateStacked(
        dateStamp: Date(),
        variant: .short(showIcon: false),
        fontSize: .title4,
        isReversed: true
      )
      PBDateStacked(
        dateStamp: Date(),
        variant: .short(showIcon: false),
        fontSize: .title3,
        isReversed: true
      )
    }
  }
  var sizesView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateStacked(
        dateStamp: Date(),
        variant: .short(showIcon: false),
        fontSize: .title4,
        isMonthStacked: true
      )
      PBDateStacked(
        dateStamp: Date(),
        variant: .short(showIcon: false),
        fontSize: .title3,
        isMonthStacked: true
      )
    }
  }
  var boldView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
        PBDateStacked(
          alignment: .leading,
          dateStamp: Date(),
          variant: .short(showIcon: false),
          fontSize: .title4,
          isBold: true,
          isMonthStacked: true
        )
        PBDateStacked(
          alignment: .center,
          dateStamp: Date().makeDate(year: 2018, month: 3, day: 20),
          variant: .standard,
          fontSize: .title4,
          isBold: true,
          isStandardStacked: true
        )
        .frame(maxWidth: .infinity, alignment: .center)
        PBDateStacked(
          alignment: .trailing, 
          dateStamp: Date(),
          variant: .short(showIcon: false),
          fontSize: .title4,
          isBold: true,
          isMonthStacked: true
        )
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
}
#Preview {
    DateStackedCatalog()
}
