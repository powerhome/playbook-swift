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
  let startTime: String
  let endTime: String
  let showIcon: Bool
  let size: PBFont
  let showTimeZone: Bool
  let isTimeBold: Bool
  let isIconBold: Bool
  let isArrowIconBold: Bool
  let isTimeZoneBold: Bool
  let isLowercase: Bool
  public init(
    alignment: Alignment = .leading,
    startTime: String = "",
    endTime: String = "",
    showIcon: Bool = false,
    size: PBFont = .caption,
    showTimeZone: Bool = false,
    isTimeBold: Bool = false,
    isIconBold: Bool = false,
    isArrowIconBold: Bool = false,
    isTimeZoneBold: Bool = false,
    isLowercase: Bool = false
  ){
    self.alignment = alignment
    self.startTime = startTime
    self.endTime = endTime
    self.showIcon = showIcon
    self.size = size
    self.showTimeZone = showTimeZone
    self.isTimeBold = isTimeBold
    self.isIconBold = isIconBold
    self.isArrowIconBold = isArrowIconBold
    self.isTimeZoneBold = isTimeZoneBold
    self.isLowercase = isLowercase
  }
    public var body: some View {
      VStack(alignment: .leading, spacing: Spacing.medium) {
        timeRangeView
       
      }
    }
}
public extension PBTimeRangeInline {
  var timeRangeView: some View {
    return HStack {
      PBTime(showTimeZone: showTimeZone, showIcon: showIcon, isLowercase: isLowercase, isBold: isTimeBold, isIconBold: isIconBold, alignment: alignment, unstyled: size, timeIdentifier: startTime)
      timeRangeIcon
      PBTime(showTimeZone: showTimeZone, showIcon: showIcon, variant: showTimeZone ? .iconTimeZone : .time, isLowercase: isLowercase, isBold: isTimeBold, isIconBold: isIconBold, alignment: alignment, unstyled: size, timeIdentifier: endTime)
    }.pbFont(size, color: fontIconColor)
     .frame(maxWidth: .infinity, alignment: alignment)
  }
  var timeRangeIcon: some View {
      PBIcon(FontAwesome.arrowRight)
  }
  
  var fontIconColor: Color {
    isTimeBold || isTimeZoneBold  ? .text(.default) : isArrowIconBold ? .text(.default) : .text(.light)
  }
}
#Preview {
  registerFonts()
  return TimeRangeInlineCatalog()
}
