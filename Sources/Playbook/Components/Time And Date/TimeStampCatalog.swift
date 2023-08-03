//
//  TextInputCatalog.swift
//
//
//  Created by Israel Molestina on 6/13/23.
//

import SwiftUI

public struct TimeStampCatalog: View {

  public init() {}

  let addThreeYear: TimeInterval = 126_230_400
  let subOneYear: TimeInterval = -31_536_000

  let minWidth: CGFloat = 0
  public var body: some View {
    List {
      Section("Default") {
        defaultView()
      }

      Section("Alignments") {
        alginmentView()
      }

      Section("Timezones") {
        timeZoneView()
      }

      Section("Last Updated By") {
        lastUpdatedView()
      }

      Section("Time Ago") {
        timeAgoView()
      }
    }
    .navigationTitle("TimeStamp")
  }

  func defaultView() -> some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBTimestamp(
        Date(),
        showDate: false
      )
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

      PBTimestamp(
        Date()
      )
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

      PBTimestamp(
        Date().addingTimeInterval(addThreeYear)
      )
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

      PBTimestamp(
        Date().addingTimeInterval(subOneYear)
      )
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
    }
  }

  func alginmentView() -> some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      Group {
        PBTimestamp(
          Date(),
          showDate: false
        )
        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

        PBTimestamp(Date())
          .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

        PBTimestamp(Date().addingTimeInterval(addThreeYear))
          .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

        PBTimestamp(Date().addingTimeInterval(subOneYear))
          .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
      }

      Group {
        PBTimestamp(
          Date(),
          showDate: false
        )
        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .center)

        PBTimestamp(Date())
          .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .center)

        PBTimestamp(Date().addingTimeInterval(addThreeYear))
          .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .center)

        PBTimestamp(Date().addingTimeInterval(subOneYear))
          .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .center)
      }

      Group {
        PBTimestamp(
          Date(),
          showDate: false
        )
        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .trailing)

        PBTimestamp(Date())
          .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .trailing)

        PBTimestamp(Date().addingTimeInterval(addThreeYear))
          .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .trailing)

        PBTimestamp(Date().addingTimeInterval(subOneYear))
          .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .trailing)
      }
    }
  }

  func timeZoneView() -> some View {
    VStack(alignment: .leading, spacing: Spacing.small) {

      Group {
        PBTimestamp(
          Date(),
          showDate: false,
          showTimeZone: true,
          timeZone: "America/New_York"
        )
        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

        PBTimestamp(
          Date(),
          showTimeZone: true,
          timeZone: "America/New_York"
        )
        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

        PBTimestamp(
          Date().addingTimeInterval(addThreeYear),
          showTimeZone: true,
          timeZone: "America/New_York"
        )
        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

        PBTimestamp(
          Date().addingTimeInterval(subOneYear),
          showTimeZone: true,
          timeZone: "America/New_York"
        )
        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
      }

      Group {
        PBTimestamp(
          Date(),
          showDate: false,
          showTimeZone: true,
          timeZone: "Asia/Hong_Kong"
        )
        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

        PBTimestamp(
          Date(),
          showTimeZone: true,
          timeZone: "Asia/Hong_Kong"
        )
        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

        PBTimestamp(
          Date().addingTimeInterval(addThreeYear),
          showTimeZone: true,
          timeZone: "Asia/Hong_Kong"
        )
        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

        PBTimestamp(
          Date().addingTimeInterval(subOneYear),
          showTimeZone: true,
          timeZone: "Asia/Hong_Kong"
        )
        .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
      }

    }
  }

  func lastUpdatedView() -> some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBTimestamp(
        Date().addingTimeInterval(-12),
        showUser: true,
        text: "Maricris Nanota",
        variant: .updated
      )
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

      PBTimestamp(
        Date().addingTimeInterval(-12),
        variant: .updated
      )
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
    }
  }

  func timeAgoView() -> some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBTimestamp(
        Date().addingTimeInterval(-10),
        showUser: true,
        text: "Maricris Nanota",
        variant: .elapsed
      )
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

      PBTimestamp(
        Date().addingTimeInterval(-36000),
        variant: .elapsed
      )
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

      PBTimestamp(
        Date().addingTimeInterval(-36000),
        variant: .hideUserElapsed
      )
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

    }
  }

}
