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
  let isLowercased: Bool?
  var header: String
  public init(
    date: Date = Date(),
    showTimeZone: Bool = false,
    showIcon: Bool = false,
    iconSize: PBIcon.IconSize = .small,
    variant: Variant = .withTimeZone,
    isLowercased: Bool = false,
    header: String = ""
  ) {
    self.date = date
    self.showTimeZone = showTimeZone
    self.showIcon = showIcon
    self.variant = variant
    self.isLowercased = isLowercased
    self.iconSize = iconSize
    self.header = header
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
  var withHeader: String {
      return header
  }
  var withIcon: some View {
    return HStack {
     PBIcon(FontAwesome.clock, size: iconSize)
      Text("\(formattedTime)" )
    }.pbFont(.caption, variant: .light, color: .text(.light))
  }
  var formattedTime: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mma"
    formatter.amSymbol = isLowercased == true ? "a" : "A"
    formatter.pmSymbol = isLowercased == true ? "p" : "P"
    return formatter.string(from: date ?? Date())
  }
  var timeZone: String {
      return TimeZone.current.localizedName(for: .shortStandard, locale: .current) ?? TimeZone.current.identifier
  }
  @ViewBuilder
  var versions: some View {
    switch variant {
    case .time:
      Text("\(formattedTime)")
        .pbFont(.caption, variant: .light, color: .text(.light))
    case .withTimeZone:
      Text("\(formattedTime) \(timeZone)" )
        .pbFont(.caption, variant: .light, color: .text(.light))
    case .withIcon:
      withIcon
    case .iconTimeZone:
      HStack {
        withIcon
        Text("\(timeZone)")
          .pbFont(.caption, variant: .light, color: .text(.light))
      }
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
