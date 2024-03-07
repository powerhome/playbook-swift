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
  let showStartTimeZone: Bool
  let showEndTimeZone: Bool
  let isTimeBold: Bool
  let isIconBold: Bool
  let isArrowIconBold: Bool
  let isTimeZoneBold: Bool
  let isLowercase: Bool
  var startVariant: PBTime.Variant?
  var endVariant: PBTime.Variant?
  var zone: PBTime.Zones?
  public init(
    alignment: Alignment = .leading,
    size: PBFont = .caption,
    startTime: String = "",
    endTime: String = "",
    showIcon: Bool = false,
    showStartTimeZone: Bool = false,
    showEndTimeZone: Bool = false,
    isTimeBold: Bool = false,
    isIconBold: Bool = false,
    isArrowIconBold: Bool = false,
    isTimeZoneBold: Bool = false,
    isLowercase: Bool = false,
    startVariant: PBTime.Variant? = .time,
    endVariant: PBTime.Variant? = .time,
    zone: PBTime.Zones? = .east
  ){
    self.alignment = alignment
    self.size = size
    self.startTime = startTime
    self.endTime = endTime
    self.showIcon = showIcon
    self.showStartTimeZone = showStartTimeZone
    self.showEndTimeZone = showEndTimeZone
    self.isTimeBold = isTimeBold
    self.isIconBold = isIconBold
    self.isArrowIconBold = isArrowIconBold
    self.isTimeZoneBold = isTimeZoneBold
    self.isLowercase = isLowercase
    self.startVariant = startVariant
    self.endVariant = endVariant
    self.zone = zone  }
  public var body: some View {
    timeRangeView
  }
}
public extension PBTimeRangeInline {
  var timeRangeView: some View {
    return HStack {
      PBTime(
        showTimeZone: showStartTimeZone,
        showIcon: showIcon,
        variant: startVariant ?? .time,
        isLowercase: isLowercase,
        isBold: isTimeBold,
        isIconBold: isIconBold,
        alignment: alignment,
        zone: zone ?? .east,
        isTimeZoneBold: isTimeZoneBold,
        unstyled: size,
        timeIdentifier: startTime
      )
      timeRangeIcon
      PBTime(
        showTimeZone: showEndTimeZone,
        showIcon: showIcon,
        variant: endVariant ?? .time,
        isLowercase: isLowercase,
        isBold: isTimeBold,
        isIconBold: isIconBold,
        alignment: alignment,
        zone: zone ?? .east,
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
