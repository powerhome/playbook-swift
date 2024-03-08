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
  let alignment: Alignment
  let date: Date
  let time: PBTime.Variant
  let timeZone: PBTime.Variant
  let timeZoneIdentifier: String
  let isLowercase: Bool
  let timeStyle: PBFont
  let timeZoneStyle: PBFont
  public init(
    alignment: Alignment = .leading,
    date: Date = Date(),
    time: PBTime.Variant = .time,
    timeZone: PBTime.Variant = .timeZone,
    timeZoneIdentifier: String = "",
    isLowercase: Bool = false,
    timeStyle: PBFont = .caption,
    timeZoneStyle: PBFont = .body
  ) {
    self.alignment = alignment
    self.date = date
    self.time = time
    self.timeZone = timeZone
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
    VStack(spacing: Spacing.xxSmall) {
      timeView
      timeZoneView
    }
  }
  var timeView: some View {
    PBTime(
      variant: time,
      isLowercase: isLowercase,
      unstyled: timeStyle,
      timeIdentifier: timeZoneIdentifier
    )
    .frame(maxWidth: .infinity, alignment: alignment)
  }
  
  var timeZoneView: some View {
    PBTime(
      variant: timeZone,
      timeIdentifier: timeZoneIdentifier
    )
    .pbFont(timeZoneStyle, color: .text(.light))
    .frame(maxWidth: .infinity, alignment: alignment)
  }
}
#Preview {
  registerFonts()
  return TimeStackedCatalog()
}
