//
//  PBDate.swift
//
//
//  Created by Rachel Radford on 11/8/23.
//

import SwiftUI

public struct PBDate: View {
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
      Text(formattedDate)
        .pbFont(typography)
    }
    .frame(maxWidth: .infinity, alignment: alignment)
  }
  
  var formattedDate: AttributedString {
    let formatter = DateFormatter()
    formatter.dateFormat = variant.dateStyle
    return colorAttributedText(formatter.string(from: datestamp), characterToChange: "•", color: .text(.light))
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

var getCurrentYear: Int {
  let calendar = Calendar.current
  let currentYear = calendar.component(.year, from: Date())
  return currentYear
}

public extension PBDate {
  enum Variant: CaseIterable, Hashable {
    case short, standard, dayDate, withIcon(isStandard: Bool)
    
    public static var allCases: [PBDate.Variant] = [.short, .dayDate, .standard, .withIcon(isStandard: true), .withIcon(isStandard: false)]
    
    public static var showCases: [PBDate.Variant] {
      return [.short, .standard, .dayDate]
    }
    
    var dateStyle: String {
      switch self {
      case .short: return getCurrentYear == getCurrentYear ? "MMM d" : ""
      case .standard: return getCurrentYear == getCurrentYear ? "MMM d" : "MMM d, YYYY"
      case .dayDate: return getCurrentYear == getCurrentYear ? "EEE • MMM d" : "EEE • MMM d, YYYY"
      case .withIcon(let isStandard): return isStandard && getCurrentYear == getCurrentYear ? "MMM d" : isStandard && getCurrentYear != getCurrentYear ? "MMM d, YYYY" : !isStandard && getCurrentYear == getCurrentYear ? "EEE • MMM d" : "EEE • MMM d, YYYY"
      }
    }
  }
}

public struct PBDate_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return DateCatalog()
  }
}
