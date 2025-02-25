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
  let size: PBFont
  let iconSize: PBIcon.IconSize
  let startDate: String
  let endDate: String
  let startVariant: PBDate.Variant
  let endVariant: PBDate.Variant
  let isArrowIconBold: Bool

  public init(
    date: Date = Date(),
    size: PBFont = .body,
    iconSize: PBIcon.IconSize = .xSmall,
    startDate: String = "",
    endDate: String = "",
    startVariant: PBDate.Variant = .standard,
    endVariant: PBDate.Variant = .standard,
    isArrowIconBold: Bool = false
  ) {
    self.date = date
    self.size = size
    self.iconSize = iconSize
    self.startDate = startDate
    self.endDate = endDate
    self.startVariant = startVariant
    self.endVariant = endVariant
    self.isArrowIconBold = isArrowIconBold
  }

  public var body: some View {
    VStack(spacing: Spacing.medium) {
      dateView
    }
  }
}

extension PBDateRangeInline {
  var dateView: some View {
    HStack {
      PBDate(getDate(dateString: startDate), variant: startVariant, typography: size, iconSize: iconSize)
      dateRangeIcon
      PBDate(getDate(dateString: endDate), variant: endVariant, typography: size, iconSize: iconSize)
    }
  }

  var dateRangeIcon: some View {
    PBIcon(FontAwesome.arrowRight, size: iconSize)
      .pbFont(size, color: isArrowIconBold ? .text(.default) : .text(.light))
  }

  func getDate(dateString: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy"
    let formattedDate = formatter.date(from: dateString) ?? date
    return formattedDate
  }
}

//#Preview {
//  registerFonts()
//  return DateRangeInlineCatalog()
//}
