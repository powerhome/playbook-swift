//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBProgressSimple.swift
//

import SwiftUI

public struct PBProgressSimple: View {
  @Binding var progress: Double
  @Binding var value: Int
  let maxValue: Int
  let progressColor: Color
  let variant: Variant
  
  public init(
    progress: Binding<Double> = .constant(0.0),
    value: Binding<Int> = .constant(2),
    maxValue: Int = 10,
    progressColor: Color = .pbPrimary,
    variant: Variant = .default
    
  ) {
    self._progress = progress
    self._value = value
    self.maxValue = maxValue
    self.progressColor = progressColor
    self.variant = variant
  }
  
  public var body: some View {
    variantView
  }
}

public extension PBProgressSimple {
  enum Variant {
    case `default`, settingValue
  }
  
  var variantView: some View {
    HStack {
      switch variant {
      case .default: ProgressView(value: progress, total: 1)
      case .settingValue: ProgressView(value: CGFloat(value), total: CGFloat(maxValue))
      }
    }
    .tint(progressColor)
    
  }
}
#Preview {
  registerFonts()
  return PBProgressSimple()
}
