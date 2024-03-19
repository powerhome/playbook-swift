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
  public init(
    alignment: HorizontalAlignment = .leading,
    dateStamp: Date = Date(),
    dateString: String = "",
    variant: PBDate.Variant = .short,
    fontSize: PBFont = .body,
    isReversed: Bool = false,
    isBold: Bool = false
  ){
    self.alignment = alignment
    self.variant = variant
    self.dateStamp = dateStamp
    self.dateString = dateString
    self.fontSize = fontSize
    self.isReversed = isReversed
    self.isBold = isBold
  }
    public var body: some View {
      formattedDate
    }
}

extension PBDateStacked {
  var dateStackedView: some View {
    formattedDate
    
  }
  /// **** You still need this for the isReversed
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
    Text(dateStamp.formatted(.dateTime.month()))
      .pbFont(.caption, variant: .bold, color: isBold ? .text(.default) : .text(.light))
  }
  var dateView: some View {
    Text(dateStamp.formatted(.dateTime.day()))
      .pbFont(fontSize, variant: .bold, color: .text(.default))
  }
  var yearView: some View {
    Text(dateStamp.formatted(.dateTime.year())).pbFont(.caption, variant: .bold, color: isBold ? .text(.default) : .text(.light))
  }
  @ViewBuilder
  var formattedDate: some View {
    switch variant {
    case .short:
      dateMonthView
    case .standard:
      fullDateView
    default:
      Text("MMM \nd")
    }
  }
  var dateStyle: String {
    switch variant {
    case .short: return "MMM \nd"
    case .standard: return "MMM \nd, \nYYYY"
    default:
      return "MMM \nd"
    }
  }
}
#Preview {
  registerFonts()
   return DateStackedCatalog()
}
