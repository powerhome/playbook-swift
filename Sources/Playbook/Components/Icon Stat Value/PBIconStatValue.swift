//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBIconStatValue.swift
//

import SwiftUI

public struct PBIconStatValue: View {
  let icon: FontAwesome
  let iconSize: PBIcon.IconSize
  let iconColor: Color
  let value: String
  let unit: String
  let text: String
  let valueFontSize: PBFont
  let unitFontSize: PBFont
  let textFontSize: PBFont
  let valueColor: Color
  let unitColor: Color
  let textColor: Color
  let unitBaselineOffset: CGFloat
  public init(
    icon: FontAwesome = .lightbulbOn,
    iconSize: PBIcon.IconSize = .small,
    iconColor: Color = .status(.neutral),
    value: String = "",
    unit: String = "",
    text: String = "",
    valueFontSize: PBFont = .title3,
    unitFontSize: PBFont = .body,
    textFontSize: PBFont = .caption,
    valueColor: Color = .text(.default),
    unitColor: Color = .text(.default),
    textColor: Color = .text(.light),
    unitBaselineOffset: CGFloat = -5
  ) {
    self.icon = icon
    self.iconSize = iconSize
    self.iconColor = iconColor
    self.value = value
    self.unit = unit
    self.text = text
    self.valueFontSize = valueFontSize
    self.unitFontSize = unitFontSize
    self.textFontSize = textFontSize
    self.valueColor = valueColor
    self.unitColor = unitColor
    self.textColor = textColor
    self.unitBaselineOffset = unitBaselineOffset
  }
  
  public var body: some View {
    iconStatView
  }
}

extension PBIconStatValue {
  var iconStatView: some View {
    HStack(spacing: Spacing.small) {
      iconView
      statValueTextView
    }
  }
  var iconView: some View {
    PBIconCircle(icon, size: iconSize, color: iconColor)
  }
  var statValueTextView: some View {
    VStack(alignment: .leading, spacing: Spacing.xxSmall){
      HStack(spacing: Spacing.xxSmall) {
        valueTextView
        unitTextView
      }
      textView
    }
  }
  var valueTextView: some View {
    Text(value)
      .pbFont(valueFontSize, variant: .bold, color: valueColor)
  }
  var unitTextView: some View {
    Text(unit)
      .textCase(.lowercase)
      .pbFont(unitFontSize, variant: .bold, color: unitColor)
     
      .baselineOffset(unitBaselineOffset)
  }
  var textView: some View {
    Text(text)
      .pbFont(textFontSize, variant: .bold, color: textColor)
  }
}

#Preview {
  registerFonts()
  return PBIconStatValue()
}
