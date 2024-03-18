//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDateRangeInline.swift
//

import SwiftUI

public struct PBDateRangeInline: View {
  let date: Date
  let alignment: HorizontalAlignment
  let size: PBFont
  let endDate: String
  let startDate: String
  let variant: PBDate.Variant
  let isArrowIconBold: Bool
  public init(
    date: Date = Date(),
    alignment: HorizontalAlignment = .leading,
    size: PBFont = .body,
    startDate: String = "",
    endDate: String = "",
    variant: PBDate.Variant = .standard,
    isArrowIconBold: Bool = false
    
  ) {
    self.date = date
    self.alignment = alignment
    self.size = size
    self.startDate = startDate
    self.endDate = endDate
    self.variant = variant
    self.isArrowIconBold = isArrowIconBold
  }
    public var body: some View {
      VStack(alignment: alignment, spacing: Spacing.xSmall) {
          dateView
      }
    }
}
extension PBDateRangeInline {
  var dateView: some View {
    HStack {
      PBDate(getDate(dateString: startDate), variant: variant, typography: size)
      dateRangeIcon
      PBDate(getDate(dateString: endDate), variant: variant, typography: size)
    }
  }
  var dateRangeIcon: some View {
    PBIcon(FontAwesome.arrowRight)
      .pbFont(size, color: isArrowIconBold ? .text(.default) : .text(.light))
  }
  func getDate(dateString: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy"
    let formattedDate = formatter.date(from: dateString) ?? Date()
    return formattedDate
  }
}

#Preview {
  registerFonts()
  return DateRangeInlineCatalog()
}
