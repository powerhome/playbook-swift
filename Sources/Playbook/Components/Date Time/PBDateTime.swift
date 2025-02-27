//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDateTime.swift
//

import SwiftUI

public struct PBDateTime: View {
  let dateTime: Date
  let iconSize: PBIcon.IconSize
  let dateVariant: PBDate.Variant
  let timeVariant: PBTime.Variant
  let timeFontSize: PBFont
  let isLowercase: Bool
  let isTimeBold: Bool
  let zone: PBTime.Zones
  let showTimeZone: Bool
  let timeZoneIdentifier: String
  let showIcon: Bool
  let dateFontSize: PBFont

  public init(
    dateTime: Date = Date(),
    iconSize: PBIcon.IconSize = .x3,
    dateVariant: PBDate.Variant = .dayDate(showYear: false),
    timeVariant: PBTime.Variant = .time,
    timeFontSize: PBFont = .body,
    isLowercase: Bool = false,
    isTimeBold: Bool = false,
    zone: PBTime.Zones = .east,
    showTimeZone: Bool = false,
    timeZoneIdentifier: String = "",
    showIcon: Bool = false,
    dateFontSize: PBFont = .title4
  ) {
    self.dateTime = dateTime
    self.iconSize = iconSize
    self.dateVariant = dateVariant
    self.timeVariant = timeVariant
    self.timeFontSize = timeFontSize
    self.isLowercase = isLowercase
    self.isTimeBold = isTimeBold
    self.zone = zone
    self.showTimeZone = showTimeZone
    self.timeZoneIdentifier = timeZoneIdentifier
    self.showIcon = showIcon
    self.dateFontSize = dateFontSize
  }

  public var body: some View {
      dateTimeView
  }
}

extension PBDateTime {
  var dateTimeView: some View {
    HStack(spacing: Spacing.small) {
      dateView
      timeView
    }
  }

  var dateView: some View {
    PBDate(
      dateTime,
      variant: dateVariant,
      typography: dateFontSize,
      iconSize: iconSize
    )
  }

  var timeView: some View {
    PBTime(
      showTimeZone: showTimeZone,
      showIcon: showIcon,
      variant: timeVariant,
      isLowercase: isLowercase,
      isBold: isTimeBold,
      zone: zone,
      unstyled: timeFontSize,
      timeIdentifier: timeZoneIdentifier
    )
  }
}

#Preview {
  registerFonts()
  return PBDateTime(
    dateVariant: .dayDate(showYear: true),
    timeVariant: .iconTimeZone,
    timeFontSize: .body,
    isLowercase: true,
    isTimeBold: true,
    timeZoneIdentifier: "EST",
    dateFontSize: .title4
  )
}
