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
  let label: String?
  let pillValue: String?
  let offset: Double?
  let horizontalPadding: CGFloat?
  public init(
    variant: PBPill.Variant = .neutral,
    label: String? = "Service Needed",
    pillValue: String? = "76",
    offset: Double? = -5.5,
    horizontalPadding: CGFloat? = Spacing.xSmall
  ) {
    self.variant = variant
    self.label = label
    self.pillValue = pillValue
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
  }
  var labelView: some View {
    PBLabelValue(label ?? "")
      .baselineOffset(offset ?? -5.5)
  }
  var pillView: some View {
    PBPill(pillValue ?? "", variant: variant)
  }
}
#Preview {
  registerFonts()
  return PBLabelPill(pillValue: "")
}
