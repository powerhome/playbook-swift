//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDateRangeStacked.swift
//

import SwiftUI

public struct PBDateRangeStacked: View {
  let startDate: Date
  let endDate: Date
  let startAlignment: HorizontalAlignment
  let endAlignment: HorizontalAlignment
  let startVariant: PBDate.Variant
  let endVariant: PBDate.Variant

  public init(
    startDate: Date = Date(),
    endDate: Date = Date(),
    startAlignment: HorizontalAlignment = .leading,
    endAlignment: HorizontalAlignment = .leading,
    startVariant: PBDate.Variant = .short(showIcon: false),
    endVariant: PBDate.Variant = .short(showIcon: false)
  ) {
    self.startDate = startDate
    self.endDate = endDate
    self.startAlignment = startAlignment
    self.endAlignment = endAlignment
    self.startVariant = startVariant
    self.endVariant = endVariant
  }

  public var body: some View {
    fullDateRangeView
  }
}

extension PBDateRangeStacked {
  var fullDateRangeView: some View {
    HStack(spacing: Spacing.small) {
      PBDateYearStacked(date: startDate, alignment: startAlignment, variant: startVariant)
      arrowIconView
      PBDateYearStacked(date: endDate, alignment: endAlignment, variant: endVariant)
    }

  }

  var arrowIconView: some View {
    PBIcon(FontAwesome.arrowRight)
      .pbFont(.body, variant: .bold, color: .text(.light))
  }
}

#Preview {
  registerFonts()
   return  DateRangeStackedCatalog()
}
