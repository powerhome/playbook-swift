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
  let label: String
  let pillValue: String?
  let horizontalSpacing: CGFloat?
  public init(
    variant: PBPill.Variant = .neutral,
    label: String = "",
    pillValue: String? = nil,
    horizontalSpacing: CGFloat? = Spacing.xSmall
  ) {
    self.variant = variant
    self.label = label
    self.pillValue = pillValue
    self.horizontalSpacing = horizontalSpacing
  }
  
  public var body: some View {
    pillLabelView
  }
}

public extension PBLabelPill {
  var pillLabelView: some View {
    HStack(spacing: horizontalSpacing) {
      labelView
      pillView
    }
  }
  @ViewBuilder
  var labelView: some View {
        PBLabelValue(label)
          .baselineOffset(-5.5)
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
