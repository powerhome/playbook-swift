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
        variant: .short,
        fontSize: .title4
      )
      PBDateStacked(
        dateStamp: Date(),
        variant: .short,
        fontSize: .title3
      )
    }
  }
  var notCurrentYearView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateStacked(
        alignment: .leading,
        dateStamp: Date().makeDate(year: 2018, month: 3, day: 20),
        variant: .standard,
        fontSize: .title4
      )
      PBDateStacked(
        dateStamp: Date().makeDate(year: 2018, month: 3, day: 20),
        variant: .standard,
        fontSize: .title3
      )
    }
  }
  var dayMonthReversedView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateStacked(
        dateStamp: Date(),
        variant: .short,
        fontSize: .title4,
        isReversed: true
      )
      PBDateStacked(
        dateStamp: Date(),
        variant: .short,
        fontSize: .title3,
        isReversed: true
      )
    }
  }
  var sizesView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBDateStacked(
        dateStamp: Date(),
        variant: .short,
        fontSize: .title4
      )
      PBDateStacked(
        dateStamp: Date(),
        variant: .short,
        fontSize: .title3
      )
    }
  }
  var boldView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
        PBDateStacked(
          dateStamp: Date(),
          variant: .short,
          fontSize: .title4,
          isBold: true
        )
        PBDateStacked(
          alignment: .center,
          dateStamp: Date().makeDate(year: 2018, month: 3, day: 20),
          variant: .standard,
          fontSize: .title4,
          isBold: true
        )
        .frame(maxWidth: .infinity, alignment: .center)
        PBDateStacked(
          alignment: .trailing, 
          dateStamp: Date(),
          variant: .short,
          fontSize: .title4,
          isBold: true
        )
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
}
#Preview {
    DateStackedCatalog()
}
