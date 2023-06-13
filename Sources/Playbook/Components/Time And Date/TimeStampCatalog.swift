//
//  SwiftUIView.swift
//
//
//  Created by Israel Molestina on 6/13/23.
//

import SwiftUI

public struct TimeStampCatalog: View {

  public init() {}

  public var body: some View {
    let timeInterval: TimeInterval = 31_536_000
    let minWidth: CGFloat = 0
    List {
      Section("Default") {
        VStack(alignment: .leading, spacing: nil) {
          PBTimestamp(Date(), showDate: false)
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
          PBTimestamp(Date())
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
          PBTimestamp(Date().addingTimeInterval(timeInterval))
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
        }
      }

      Section("Alignments") {
        VStack(alignment: .leading, spacing: nil) {
          PBTimestamp(Date(), showDate: false)
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
          PBTimestamp(Date())
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
          PBTimestamp(Date().addingTimeInterval(timeInterval))
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

          PBTimestamp(Date(), showDate: false)
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .center)
          PBTimestamp(Date())
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .center)
          PBTimestamp(Date().addingTimeInterval(timeInterval))
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .center)

          PBTimestamp(Date(), showDate: false)
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .trailing)
          PBTimestamp(Date())
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .trailing)
          PBTimestamp(Date().addingTimeInterval(timeInterval))
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .trailing)
        }
      }

      Section("Timezones") {
        VStack(alignment: .leading, spacing: nil) {
          PBTimestamp(Date(), showDate: false, showTimeZone: true, timeZone: "America/New_York")
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
          PBTimestamp(Date(), showTimeZone: true, timeZone: "America/New_York")
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
          PBTimestamp(
            Date().addingTimeInterval(timeInterval),
            showTimeZone: true,
            timeZone: "America/New_York"
          )
          .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

          PBTimestamp(Date(), showDate: false, showTimeZone: true, timeZone: "Asia/Hong_Kong")
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
          PBTimestamp(Date(), showTimeZone: true, timeZone: "Asia/Hong_Kong")
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
          PBTimestamp(Date().addingTimeInterval(timeInterval), showTimeZone: true, timeZone: "Asia/Hong_Kong")
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
        }
      }

      Section("Last Updated By") {
        VStack(alignment: .leading, spacing: nil) {
          PBTimestamp(
            Date().addingTimeInterval(-12),
            showUser: true,
            text: "Andrew Black",
            variant: .updated
          )
          .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
          PBTimestamp(Date().addingTimeInterval(-12), variant: .updated)
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
        }
      }

      Section("Time Ago") {
        VStack(alignment: .leading, spacing: nil) {
          PBTimestamp(
            Date().addingTimeInterval(-10),
            showUser: true,
            text: "Andrew Black",
            variant: .elapsed
          )
          .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
          PBTimestamp(Date().addingTimeInterval(-88000), variant: .elapsed)
            .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
        }
      }
    }
  }
}
