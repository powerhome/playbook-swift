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
  
  public init(
    variant: PBPill.Variant = .neutral,
    labelValue: String? = "Service Needed",
    pillValue: String? = "76",
    labelFontSize: PBFont = .caption,
    labelColor: Color = Color.text(.default)
  ) {
    self.variant = variant
    self.labelValue = labelValue
    self.pillValue = pillValue
    self.labelFontSize = labelFontSize
    self.labelColor = labelColor
  }
  
    public var body: some View {
      pillLabelView
//      HStack {
//        PBLabelValue("Service Needed")
//        PBPill("76", variant: .neutral)
//         
//      }
//     

    }
}

public extension PBLabelPill {
  var pillLabelView: some View {
    HStack {
      PBLabelValue(labelValue ?? "")
      PBPill(pillValue ?? "", variant: variant)
    }
    .pbFont(labelFontSize, color: labelColor)
  }
}
#Preview {
  registerFonts()
  return PBLabelPill(pillValue: "", labelFontSize: .caption, labelColor: .active)
}
/*
 
 
 label: string
 pillValue: string
 variant:
 "error" | "info" | "neutral" | "primary" | "success" | "warning"
 
 
 
 */
