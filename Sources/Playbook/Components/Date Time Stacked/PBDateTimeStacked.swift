//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDateTimeStacked.swift
//

import SwiftUI

public struct PBDateTimeStacked: View {
  let dateTime: Date
  let timeDate: Date
  let timeZoneIdentifier: String
  let isYearDisplayed: Bool
  let isLowercase: Bool
  let isMonthStacked: Bool
  let isMonthBold: Bool
  let isYearBold: Bool
  let dateAlignment: HorizontalAlignment
  let timeAlignment: HorizontalAlignment
  let dateVariant: PBDate.Variant
  let timeVariant: PBTime.Variant
  let dateSize: PBFont
  let timeStyle: PBFont
  let timeZoneStyle: PBFont
  public init(
    dateTime: Date = Date(),
    timeDate: Date = Date(),
    timeZoneIdentifier: String = "",
    isYearDisplayed: Bool = false,
    isLowercase: Bool = false,
    isMonthStacked: Bool = false,
    isMonthBold: Bool = false,
    isYearBold: Bool = false,
    dateAlignment: HorizontalAlignment = .trailing,
    timeAlignment: HorizontalAlignment = .leading,
    dateVariant: PBDate.Variant = .short(showIcon: false),
    timeVariant: PBTime.Variant = .time,
    dateSize: PBFont = .title4,
    timeStyle: PBFont = .body,
    timeZoneStyle: PBFont = .caption
  ) {
    self.dateTime = dateTime
    self.timeDate = timeDate
    self.timeZoneIdentifier = timeZoneIdentifier
    self.isYearDisplayed = isYearDisplayed
    self.isLowercase = isLowercase
    self.isMonthStacked = isMonthStacked
    self.isMonthBold = isMonthBold
    self.isYearBold = isYearBold
    self.dateAlignment = dateAlignment
    self.timeAlignment = timeAlignment
    self.dateVariant = dateVariant
    self.timeVariant = timeVariant
    self.dateSize = dateSize
    self.timeStyle = timeStyle
    self.timeZoneStyle = timeZoneStyle
  }
    public var body: some View {
      dateTimeView
    }
}
extension PBDateTimeStacked {
  var dateTimeView: some View {
    HStack(spacing: Spacing.small) {
      dateView
      dividerView
      timeView
    }
  }
  var dateView: some View {
    VStack(spacing: Spacing.xxSmall) {
      if isYearDisplayed {
        Spacer()
      }
      PBDateStacked(
        alignment: dateAlignment,
        date: dateTime,
        variant: dateVariant,
        dateSize: dateSize,
        isMonthStacked: isMonthStacked,
        isYearBold: isYearBold,
        isMonthBold: isMonthBold
      )
      if isYearDisplayed {
        Spacer()
      }
    }
  }
  var dividerView: some View {
    Divider()
      .padding(.vertical, isYearDisplayed ? 9.96 : -0.5)
  }
  var timeView: some View {
    VStack(spacing: Spacing.xxSmall) {
      if isYearDisplayed {
        Spacer()
      }
      PBTimeStacked(
        alignment: timeAlignment,
        date: timeDate,
        timeVariant: timeVariant,
        timeZoneIdentifier: timeZoneIdentifier,
        isLowercase: isLowercase,
        timeStyle: timeStyle,
        timeZoneStyle: timeZoneStyle
      )
      if isYearDisplayed {
        Spacer(minLength: 30)
      }
    }
  }
}

#Preview {
  registerFonts()
  return DateTimeStackedCatalog()
}
