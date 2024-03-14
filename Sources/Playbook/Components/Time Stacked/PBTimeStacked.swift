//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTimeStacked.swift
//

import SwiftUI

public struct PBTimeStacked: View {
  let alignment: HorizontalAlignment
  let date: Date
  let timeVariant: PBTime.Variant
  let timeZoneVariant: PBTime.Variant
  let timeZoneIdentifier: String
  let isLowercase: Bool
  let timeStyle: PBFont
  let timeZoneStyle: PBFont
  public init(
    alignment:  HorizontalAlignment = .leading,
    date: Date = Date(),
    timeVariant: PBTime.Variant = .time,
    timeZoneVariant: PBTime.Variant = .timeZone,
    timeZoneIdentifier: String = "",
    isLowercase: Bool = false,
    timeStyle: PBFont = .caption,
    timeZoneStyle: PBFont = .body
  ) {
    self.alignment = alignment
    self.date = date
    self.timeVariant = timeVariant
    self.timeZoneVariant = timeZoneVariant
    self.timeZoneIdentifier = timeZoneIdentifier
    self.isLowercase = isLowercase
    self.timeStyle = timeStyle
    self.timeZoneStyle = timeZoneStyle
  }
  public var body: some View {
    timeAndZoneView
  }
}

public extension PBTimeStacked {
  var timeAndZoneView: some View {
    VStack(alignment: alignment,spacing: Spacing.xxSmall) {
      timeView
      timeZoneView
    }
  }
  var timeView: some View {
    PBTime(
      variant: timeVariant,
      isLowercase: isLowercase,
      unstyled: timeStyle,
      timeIdentifier: timeZoneIdentifier
    )
  }
  var timeZoneView: some View {
    PBTime(
      variant: timeZoneVariant,
      timeIdentifier: timeZoneIdentifier
    )
    .pbFont(timeZoneStyle)
  }
}
#Preview {
  registerFonts()
  return TimeStackedCatalog()
}
