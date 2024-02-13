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
  public init(
    date: Date = Date(),
    showTimeZone: Bool = false,
    showIcon: Bool = false,
    iconSize: PBIcon.IconSize = .small,
    variant: Variant = .withTimeZone,
    isLowercase: Bool = false,
    header: String = "",
    isBold: Bool = false
  ) {
    self.date = date
    self.showTimeZone = showTimeZone
    self.showIcon = showIcon
    self.variant = variant
    self.isLowercase = isLowercase
    self.iconSize = iconSize
    self.header = header
    self.isBold = isBold
  }
    public var body: some View {
     versions
    }
}

public extension PBTime {
  enum Variant {
    case time
    case withTimeZone
    case withIcon
    case withHeader
    case iconTimeZone
    case all
  }
  var time: some View {
    Text("\(formattedTime)")
      .pbFont(isBold ? .body : .caption, variant: isBold ? .bold : .light, color: isBold ? .text(.default) : .text(.light))
  }
  var withIcon: some View {
    return PBIcon(FontAwesome.clock, size: iconSize)
      .pbFont(.caption, variant: .light, color: .text(.light))
  }
  var formattedTime: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mma"
    formatter.amSymbol = isLowercase == true ? "a" : "A"
    formatter.pmSymbol = isLowercase == true ? "p" : "P"
    return formatter.string(from: date ?? Date())
  }
  var withTimeZone: some View {
    return HStack {
      Text("\(formattedTime)" )
        .pbFont(isBold ? .body : .caption, variant: isBold ? .bold : .light, color: isBold ? .text(.default) : .text(.light))
      Text(TimeZone.current.localizedName(for: .shortStandard, locale: .current) ?? TimeZone.current.identifier)
        .pbFont(isBold ? .body :.caption, variant: .light, color: .text(.light))
    }
  }
  var iconTimeZone: some View {
    HStack {
      withIcon
      withTimeZone
    }
  }
  var withHeader: String {
      return header
  }
  @ViewBuilder
  var versions: some View {
    switch variant {
    case .time:
      time
    case .withTimeZone:
        withTimeZone
    case .withIcon:
      HStack {
        withIcon
        time
      }
    case .iconTimeZone:
      iconTimeZone
    case .all:
      VStack {
        Text(header)
          .pbFont(.title4, variant: .bold, color:
          .text(.default))
        withIcon
      }.pbFont(.title4, variant: .light, color: .text(.light))
    default:
      Text("")
    }
  }
}

#Preview {
  registerFonts()
  return TimeCatalog()
//  return PBTime()
}
