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
  let date: Date
  let variant: PBDate.Variant
  let fontSize: PBFont
  let isReversed: Bool
  let isBold: Bool
  let isMonthStacked: Bool
  let isStandardStacked: Bool
  let isYearBold: Bool
  let isMonthBold: Bool
  public init(
    alignment: HorizontalAlignment = .leading,
    date: Date = Date(),
    variant: PBDate.Variant = .standard,
    fontSize: PBFont = .body,
    isReversed: Bool = false,
    isBold: Bool = false,
    isMonthStacked: Bool = false,
    isStandardStacked: Bool = false,
    isYearBold: Bool = false,
    isMonthBold: Bool = false
  ){
    self.alignment = alignment
    self.variant = variant
    self.date = date
    self.fontSize = fontSize
    self.isReversed = isReversed
    self.isBold = isBold
    self.isMonthStacked = isMonthStacked
    self.isStandardStacked = isStandardStacked
    self.isYearBold = isYearBold
    self.isMonthBold = isMonthBold
  }
    public var body: some View {
      dateStackedStyle
    }
}

extension PBDateStacked {
  var dateMonthView: some View {
       VStack(alignment: alignment, spacing: Spacing.xSmall) {
         if !isReversed {
           monthView
           dateView
         } else {
           dateView
           monthView
         }
       }
     }
     var fullDateView: some View {
       VStack(alignment: alignment, spacing: Spacing.xSmall) {
         monthView
         dateView
         yearView
       }
     }
     var monthView: some View {
       Text(date.formatted(.dateTime.month()))
         .pbFont(.caption, variant: .bold, color: isMonthBold ? .text(.default) : .text(.light))
     }
     var dateView: some View {
       Text(date.formatted(.dateTime.day()))
         .pbFont(fontSize, variant: .bold, color: .text(.default))
     }
     var yearView: some View {
       Text(date.formatted(.dateTime.year())).pbFont(isYearBold ? .title4 : .subcaption, variant: .bold, color: isBold ? .text(.default) : .text(.light))
     }
  @ViewBuilder
    var dateStackedStyle: some View {
        switch variant {
        case .short: dateMonthView
        case .standard: fullDateView
        default:
           dateMonthView
        }
    }
}
#Preview {
  registerFonts()
   return DateStackedCatalog()
}
