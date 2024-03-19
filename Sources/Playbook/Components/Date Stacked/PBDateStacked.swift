//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDateStacked.swift
//

import SwiftUI

public struct PBDateStacked: View {
  let alignment: HorizontalAlignment
  let dateStamp: Date
  let dateString: String
  let variant: PBDate.Variant
  let fontSize: PBFont
  let isReversed: Bool
  let isBold: Bool
  let isMonthStacked: Bool
  let isStandardStacked: Bool
  public init(
    alignment: HorizontalAlignment = .leading,
    dateStamp: Date = Date(),
    dateString: String = "",
    variant: PBDate.Variant = .standard,
    fontSize: PBFont = .body,
    isReversed: Bool = false,
    isBold: Bool = false,
    isMonthStacked: Bool = false,
    isStandardStacked: Bool = false
  ){
    self.alignment = alignment
    self.variant = variant
    self.dateStamp = dateStamp
    self.dateString = dateString
    self.fontSize = fontSize
    self.isReversed = isReversed
    self.isBold = isBold
    self.isMonthStacked = isMonthStacked
    self.isStandardStacked = isStandardStacked
  }
    public var body: some View {
      Text(formattedDate)
        .pbFont(.caption, variant: .bold, color: isBold ? .text(.default) : .text(.light))
    }
}

extension PBDateStacked {
  var dateStackedStyle: String {
      switch variant {
      case .short: return isMonthStacked && alignment == .leading ? "MMM \nd" : isReversed ? "d \nMMM" : "MMM  \n    d"
      case .standard: return isStandardStacked || alignment == .leading ?  "MMM\nd \nYYYY" : isStandardStacked || alignment == .center ? "MMM\n d \nYYYY" : "MMM \n d \nYYYY"
      default:
        return "MMM \nd"
      }
  }
  var dateStackedFont: PBFont {
    switch variant {
    case .short: return .title3
    case .standard: return .title4
    default: return .title3
    }
  }
  var formattedDate: AttributedString {
    let formatter = DateFormatter()
    formatter.dateFormat = isMonthStacked || isReversed || isStandardStacked ? dateStackedStyle : dateStackedStyle
    return colorAttributedText(formatter.string(from: dateStamp), characterToChange: "•", color: .text(.light))
  }
}
#Preview {
  registerFonts()
   return DateStackedCatalog()
}
