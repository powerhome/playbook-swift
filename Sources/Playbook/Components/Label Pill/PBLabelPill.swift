//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBLabelPill.swift
//

import SwiftUI

public struct PBLabelPill: View {
  let variant: PBPill.Variant
  let labelValue: String?
  let pillValue: String?
  let labelFontSize: PBFont
  let labelColor: Color
  let offset: Double?
  let horizontalPadding: CGFloat?
  public init(
    variant: PBPill.Variant = .neutral,
    labelValue: String? = "Service Needed",
    pillValue: String? = "76",
    labelFontSize: PBFont = .caption,
    labelColor: Color = .text(.light),
    offset: Double? = -5.5,
    horizontalPadding: CGFloat? = Spacing.xSmall
  ) {
    self.variant = variant
    self.labelValue = labelValue
    self.pillValue = pillValue
    self.labelFontSize = labelFontSize
    self.labelColor = labelColor
    self.offset = offset
    self.horizontalPadding = horizontalPadding
  }
  
  public var body: some View {
    pillLabelView
  }
}

public extension PBLabelPill {
  var pillLabelView: some View {
    HStack(spacing: horizontalPadding) {
      labelView
      pillView
    }
    .pbFont(labelFontSize, color: labelColor)
  }
  var labelView: some View {
    PBLabelValue(labelValue ?? "")
      .baselineOffset(offset ?? -5.5)
  }
  var pillView: some View {
    PBPill(pillValue ?? "", variant: variant)
  }
}
#Preview {
  registerFonts()
  return PBLabelPill(pillValue: "", labelFontSize: .caption, labelColor: .active)
}
