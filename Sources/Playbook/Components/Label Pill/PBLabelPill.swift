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
    label: String? = nil,
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
  @ViewBuilder
  var labelView: some View {
    if let label = label {
      if let offset = offset {
        PBLabelValue(label)
          .baselineOffset(offset)
      } 
    }
  }
  @ViewBuilder
  var pillView: some View {
    if let pillValue = pillValue {
      PBPill(pillValue, variant: variant)
    }
  }
}
#Preview {
  registerFonts()
  return PBLabelPill(pillValue: "")
}
