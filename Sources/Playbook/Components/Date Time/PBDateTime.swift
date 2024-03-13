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
  let showDayOfWeek: Bool
  let timeZone: String
  let dateVariant: PBDate.Variant
  let timeVariant: PBTime.Variant
  let fontSize: PBFont
  let isLowercase: Bool
  let isBold: Bool
  let isTimeZoneBold: Bool
  let zone: PBTime.Zones
  public init(
    alignment: Alignment = .leading,
    dateTime: Date = Date(),
    iconSize: PBIcon.IconSize = .x3,
    showDayOfWeek: Bool = false,
    timeZone: String = "",
    dateVariant: PBDate.Variant = .dayDate,
    timeVariant: PBTime.Variant = .time,
    fontSize: PBFont = .body,
    isLowercase: Bool = false,
    isBold: Bool = false,
    isTimeZoneBold: Bool = false,
    zone: PBTime.Zones = .east
  ) {
    self.alignment = alignment
    self.dateTime = dateTime
    self.iconSize = iconSize
    self.showDayOfWeek = showDayOfWeek
    self.timeZone = timeZone
    self.dateVariant = dateVariant
    self.timeVariant = timeVariant
    self.fontSize = fontSize
    self.isLowercase = isLowercase
    self.isBold = isBold
    self.isTimeZoneBold = isTimeZoneBold
    self.zone = zone
  }
  public var body: some View {
    dateTimeView
    
    // Need changes from time range inline kit for the color attributed string and the .time, .timeZone variants
  }
}

extension PBDateTime {
  var dateTimeView: some View {
    HStack(spacing: Spacing.small) {
      dateView
      timeView
    }
    .frame(maxWidth: .infinity, alignment: .leading)
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
      showTimeZone: false,
     // showIcon: false,
      variant: timeVariant,
      isLowercase: isLowercase,
      isBold: isBold,
      zone: zone,
      isTimeZoneBold: isTimeZoneBold,
      unstyled: fontSize
    )
  }
}

#Preview {
  registerFonts()
  return DateTimeCatalog()
}
