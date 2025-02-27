//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDate.swift
//

import SwiftUI

public struct PBDate: View {
  let datestamp: Date
  let variant: Variant
  let typography: PBFont
  let iconSize: PBIcon.IconSize

  public init(
    _ datestamp: Date,
    variant: Variant = .standard,
    typography: PBFont = .caption,
    iconSize: PBIcon.IconSize = .x1
  ) {
    self.datestamp = datestamp
    self.variant = variant
    self.typography = typography
    self.iconSize = iconSize
  }

  public var body: some View {
    HStack {
      iconView
      Text(formattedDate)
        .pbFont(typography)
    }
  }
}

private extension PBDate {
  var formattedDate: AttributedString {
    let formatter = DateFormatter()
    formatter.dateFormat = variant.dateStyle
    return colorAttributedText(formatter.string(from: datestamp), characterToChange: "•", color: .text(.light))
  }

  var iconView: AnyView? {
    switch variant {
    case .withIcon, .short(showIcon: true):
      return AnyView(PBIcon.fontAwesome(.calendarAlt, size: iconSize).foregroundStyle(Color.text(.light)))
    default:
      return nil
    }
  }

  var currentYear: Int {
    let calendar = Calendar.current
    let currentYear = calendar.component(.year, from: Date())
    return currentYear
  }

  var isCurrentYear: Bool {
    let currentDate = currentYear
    let datestampYear = Calendar.current.component(.year, from: datestamp)
    return currentDate == datestampYear
  }
}

public extension PBDate {
  enum Variant: CaseIterable, Hashable {
    case short(showIcon: Bool), standard, dayDate(showYear: Bool), withIcon(isStandard: Bool)

    public static var allCases: [PBDate.Variant] = [
      .short(showIcon: false),
      .dayDate(showYear: false),
      .standard,
      .withIcon(isStandard: true),
      .withIcon(isStandard: false)
    ]

    public static var showCases: [PBDate.Variant] {
      return [.standard]
    }

    var dateStyle: String {
      switch self {
      case .short: return "MMM d"
      case .standard: return "MMM d, YYYY"
      case .dayDate(let showYear): return showYear ? "EEE • MMM d, YYYY" : "EEE • MMM d"
      case .withIcon(let isStandard): return isStandard ? "MMM d, YYYY" : "EEE • MMM d, YYYY"
      }
    }
  }
}
