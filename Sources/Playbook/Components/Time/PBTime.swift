//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTime.swift
//

import SwiftUI

public struct PBTime: View {
  let date: Date?
  let showTimeZone: Bool
  let showIcon: Bool
  let iconSize: PBIcon.IconSize
  let variant: Variant
  let isLowercase: Bool
  let header: String
  let isBold: Bool
  let isIconBold: Bool
  let alignment: Alignment
  let zone: Zones
  let isTimeZoneBold: Bool
  let unstyled: PBFont
  let timeIdentifier: String
  public init(
    date: Date = Date(),
    showTimeZone: Bool = false,
    showIcon: Bool = false,
    iconSize: PBIcon.IconSize = .small,
    variant: Variant = .time,
    isLowercase: Bool = false,
    header: String = "",
    isBold: Bool = false,
    isIconBold: Bool = false,
    alignment: Alignment = .leading,
    zone: Zones = .east,
    isTimeZoneBold: Bool = false,
    unstyled: PBFont = .caption,
    timeIdentifier: String = "EST"
  ) {
    self.date = date
    self.showTimeZone = showTimeZone
    self.showIcon = showIcon
    self.variant = variant
    self.isLowercase = isLowercase
    self.iconSize = iconSize
    self.header = header
    self.isBold = isBold
    self.isIconBold = isIconBold
    self.alignment = alignment
    self.zone = zone
    self.isTimeZoneBold = isTimeZoneBold
    self.unstyled = unstyled
    self.timeIdentifier = timeIdentifier
  }
    public var body: some View {
     timeVariants
    }
}

public extension PBTime {
  enum Variant {
    case time
    case iconTimeZone
    case withTimeZoneHeader
  }
  enum Zones {
    case east, central, mountain, pacific, gmt
  }
  @ViewBuilder
  var timeVariants: some View {
    switch variant {
    case .time: time
    case .iconTimeZone: iconTimeZone
    case .withTimeZoneHeader: withTimeZoneHeader
    }
  }
  var headerView: some View {
    return Text(header)
      .pbFont(.title4, variant: .bold, color: .text(.default))
  }
  var timeIcon: some View {
    return PBIcon(FontAwesome.clock, size: iconSize)
      .pbFont(.caption, variant: .light, color: isIconBold ? .text(.default) : .text(.light))
  }
  @ViewBuilder
  var time: some View {
   Text(getTime(timeZoneIdentifier: timeIdentifier))
      .pbFont(unstyled, variant: isBold ? .bold : .light, color: isBold ? .text(.default) : .text(.light))
  }
  @ViewBuilder
  var timeZone: some View {
    switch zone {
    case .east, .central, .mountain, .pacific, .gmt: Text(timeIdentifier)
    }
  }
  var showIconView: some View {
    return HStack {
      timeIcon
      time
    }
    .frame(maxWidth: .infinity, alignment: alignment)
  }
  var showTimeZoneView: some View {
    return HStack {
      time
      timeZone
    }
  }
  var showIconTimeZoneView: some View {
    return HStack {
      timeIcon
      time
      timeZone
    }
  }
  var iconTimeZone: some View {
   return HStack {
    if showIcon {
      showIconView
      } else if showTimeZone {
        showTimeZoneView
      } else {
        showIconTimeZoneView
      }
    }
   .pbFont(unstyled, variant: isTimeZoneBold ? .bold : .light, color: isTimeZoneBold ? .text(.default) : .text(.light))
   .frame(maxWidth: .infinity, alignment: alignment)
  }
  var withTimeZoneHeader: some View {
    return VStack(alignment: .leading, spacing: Spacing.xSmall) {
      headerView
      iconTimeZone
    }
    .pbFont(unstyled, variant: isTimeZoneBold ? .bold : .light, color: isTimeZoneBold ? .text(.default) : .text(.light))
  }
  func getTime(timeZoneIdentifier: String) -> String {
    if let timeZone = TimeZone(abbreviation: timeZoneIdentifier) {
      let formatter = DateFormatter()
      formatter.timeZone = timeZone
      formatter.dateFormat = "h:mma"
      formatter.amSymbol = isLowercase == true ? "a" : "A"
      formatter.pmSymbol = isLowercase == true ? "p" : "P"
      return formatter.string(from: date ?? Date())
    }
    return timeZoneIdentifier
  }
}

#Preview {
  registerFonts()
  return TimeCatalog()
}
