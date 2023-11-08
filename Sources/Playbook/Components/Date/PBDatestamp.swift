//
//  SwiftUIView.swift
//
//
//  Created by Rachel Radford on 11/8/23.
//

import SwiftUI

public struct PBDatestamp: View {
  let datestamp: Date
  let variant: Variant
  let typography: PBFont
  let iconSize: PBIcon.IconSize
  let alignment: Alignment
  public init(
    _ datestamp: Date,
    variant: Variant = .short,
    typography: PBFont = .caption,
    iconSize: PBIcon.IconSize = .x1,
    alignment: Alignment = .leading
  ) {
    self.datestamp = datestamp
    self.variant = variant
    self.typography = typography
    self.iconSize = iconSize
    self.alignment = alignment
  }

  public var body: some View {
    HStack {
      iconView
      Text(datestampStyle)
        .pbFont(typography)
    }
    .frame(maxWidth: .infinity, alignment: alignment)
  }

  var formattedShortened: String {
    let formatter  = DateFormatter()
    formatter.dateFormat = "MMM d"
    return formatter.string(from: datestamp)
  }

  var formattedHyphenated: String {
    let formatter  = DateFormatter()
    formatter.dateFormat = "MMM - d - YYYY"
    return formatter.string(from: datestamp)
  }

  var formattedStandard: String {
    let formatter  = DateFormatter()
    formatter.dateFormat = "MMM d, YYYY"
    return formatter.string(from: datestamp)
  }

  var formattedDayDate: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEE \u{00b7} MMM d, YYYY"
    return formatter.string(from: datestamp)
  }

  var datestampStyle: String {
    switch variant {
    case .short: return formattedShortened
    case .standard: return formattedStandard
    case .dayDate: return formattedDayDate
    case .withIcon(let isStandard): return isStandard ? formattedStandard : formattedDayDate
    }
  }

  var iconView: AnyView? {
    switch variant {
    case .withIcon:
      return AnyView(PBIcon.fontAwesome(.calendarAlt, size: iconSize).foregroundStyle(Color.text(.light)))
    default:
      return nil
    }
  }
}

public extension PBDatestamp {
  enum Variant: CaseIterable, Hashable {
    public static var allCases: [PBDatestamp.Variant] {
      return [.short, .dayDate, .standard, .withIcon(isStandard: true), .withIcon(isStandard: false)]
    }
    public static var showCases: [PBDatestamp.Variant] {
      return [.short, .standard, .dayDate]
    }
    case short, standard, dayDate, withIcon(isStandard: Bool)
  }
}

public struct PBDatetamp_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return DatestampCatalog()
  }
}
