//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDateYearStacked.swift
//

import SwiftUI

public struct PBDateYearStacked: View {
  let date: Date
  let alignment: HorizontalAlignment
  let variant: PBDate.Variant

  public init(
    date: Date = Date(),
    alignment: HorizontalAlignment = .leading,
    variant: PBDate.Variant = .standard
  ) {
    self.date = date
    self.alignment = alignment
    self.variant = variant
  }

  public var body: some View {
    fullDateView
  }
}

extension PBDateYearStacked {
  var fullDateView: some View {
    VStack(alignment: alignment, spacing: Spacing.xxSmall) {
      dateMonthView
      yearView
    }
  }

  var dateMonthView: some View {
    HStack(spacing: Spacing.xxSmall) {
      Text(date.formatted(.dateTime.day()))
      Text(date.formatted(.dateTime.month()))
    }
    .pbFont(.title4, variant: .bold, color: .text(.default))
   
  }

  var yearView: some View {
    HStack(spacing: Spacing.xxSmall) {
      Text(date.formatted(.dateTime.year()))
    }
    .pbFont(.body, variant: .bold, color: .text(.light))
  }
}

#Preview {
  registerFonts()
   return  DateYearStackedCatalog()
}
