//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTimeRangeInline.swift
//

import SwiftUI

public struct PBTimeRangeInline: View {
  let alignment: Alignment
  let size: PBFont
  let startTime: String
  let endTime: String
  var showIcon: Bool
  let showTimeZone: Bool
  let isTimeBold: Bool
  let isIconBold: Bool
  let isArrowIconBold: Bool
  let isTimeZoneBold: Bool
  let isLowercase: Bool
  var startVariant: PBTime.Variant?
  var endVariant: PBTime.Variant?
  public init(
    alignment: Alignment = .leading,
    size: PBFont = .caption,
    startTime: String = "",
    endTime: String = "",
    showIcon: Bool = false,
    showTimeZone: Bool = false,
    isTimeBold: Bool = false,
    isIconBold: Bool = false,
    isArrowIconBold: Bool = false,
    isTimeZoneBold: Bool = false,
    isLowercase: Bool = false,
    startVariant: PBTime.Variant? = .time,
    endVariant: PBTime.Variant? = .time
  ){
    self.alignment = alignment
    self.size = size
    self.startTime = startTime
    self.endTime = endTime
    self.showIcon = showIcon
    self.showTimeZone = showTimeZone
    self.isTimeBold = isTimeBold
    self.isIconBold = isIconBold
    self.isArrowIconBold = isArrowIconBold
    self.isTimeZoneBold = isTimeZoneBold
    self.isLowercase = isLowercase
    self.startVariant = startVariant
    self.endVariant = endVariant
  }
  public var body: some View {
      timeRangeView
  }
}
public extension PBTimeRangeInline {
  var timeRangeView: some View {
    return HStack {
      PBTime(
        showTimeZone: showTimeZone,
        showIcon: showIcon,
        variant: startVariant ?? .iconTimeZone,
        isLowercase: isLowercase,
        isBold: isTimeBold,
        isIconBold: isIconBold,
        alignment: alignment,
        isTimeZoneBold: isTimeZoneBold,
        unstyled: size,
        timeIdentifier: startTime
      )
      timeRangeIcon
      PBTime(
        showTimeZone: showTimeZone,
        showIcon: showIcon,
        variant: endVariant ?? .iconTimeZone,
        isLowercase: isLowercase,
        isBold: isTimeBold,
        isIconBold: isIconBold,
        alignment: alignment,
        isTimeZoneBold: isTimeZoneBold,
        unstyled: size,
        timeIdentifier: endTime
      )
    }
    .frame(maxWidth: .infinity, alignment: alignment)
    .pbFont(size, color: fontColor)
    
    
  }
  var timeRangeIcon: some View {
    PBIcon(FontAwesome.arrowRight)
      .pbFont(size, color: isArrowIconBold ? .text(.default) : .text(.light))
  }
  var fontColor: Color{
    isTimeZoneBold ? .text(.default): .text(.light)
  }
}
#Preview {
  registerFonts()
  return TimeRangeInlineCatalog()
}
