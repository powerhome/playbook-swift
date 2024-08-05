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
      case .default: progressDefaultView
      case .settingValue: progressSettingView
      }
    }
    .tint(progressColor)
  }
  var progressDefaultView: some View {
    ProgressView(value: progress, total: 1)
  }
  var progressSettingView: some View {
    ProgressView(value: CGFloat(value), total: CGFloat(maxValue))
      .progressViewStyle(LinearProgressViewStyle())
  }
}
#Preview {
  registerFonts()
  return PBProgressSimple()
}
