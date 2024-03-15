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
  let alignment: Alignment
  let dateTime: Date
  let iconSize: PBIcon.IconSize
  let timeZone: String
  let dateVariant: PBDate.Variant
  let timeVariant: PBTime.Variant
  let fontSize: PBFont
  let isLowercase: Bool
  let isBold: Bool
  let isTimeZoneBold: Bool
  let zone: PBTime.Zones
  let showTimeZone: Bool
  let timeZoneIdentifier: String
  let showIcon: Bool
  public init(
    alignment: Alignment = .leading,
    dateTime: Date = Date(),
    iconSize: PBIcon.IconSize = .x3,
    timeZone: String = "",
    dateVariant: PBDate.Variant = .dayDate(showYear: false),
    timeVariant: PBTime.Variant = .time,
    fontSize: PBFont = .body,
    isLowercase: Bool = false,
    isBold: Bool = false,
    isTimeZoneBold: Bool = false,
    zone: PBTime.Zones = .east,
    showTimeZone: Bool = false,
    timeZoneIdentifier: String = "",
    showIcon: Bool = false
  ) {
    self.alignment = alignment
    self.dateTime = dateTime
    self.iconSize = iconSize
    self.timeZone = timeZone
    self.dateVariant = dateVariant
    self.timeVariant = timeVariant
    self.fontSize = fontSize
    self.isLowercase = isLowercase
    self.isBold = isBold
    self.isTimeZoneBold = isTimeZoneBold
    self.zone = zone
    self.showTimeZone = showTimeZone
    self.timeZoneIdentifier = timeZoneIdentifier
    self.showIcon = showIcon
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
      typography: fontSize,
      iconSize: iconSize
    )
  }
  var timeView: some View {
    PBTime(
      showTimeZone: showTimeZone,
      showIcon: showIcon,
      variant: timeVariant,
      isLowercase: isLowercase,
      isBold: isBold,
      zone: zone,
      isTimeZoneBold: isTimeZoneBold,
      unstyled: fontSize,
      timeIdentifier: timeZoneIdentifier
    )
  }
}

#Preview {
  registerFonts()
  return DateTimeCatalog()
}
