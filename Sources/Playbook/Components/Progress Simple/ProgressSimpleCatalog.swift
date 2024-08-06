//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ProgressSimpleCatalog.swift
//

import SwiftUI

public struct ProgressSimpleCatalog: View {
  @State private var progress: Double = 0.45
  @State private var progress1: Double = 0.68
  @State private var value: Int = 2
  public var body: some View {
    PBDocStack(title: "Progress Simple", spacing: Spacing.medium) {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Setting Values") {
        settingValueView
      }
    }
  }
}

public extension ProgressSimpleCatalog {
  var defaultView: some View {
    VStack(alignment: .leading) {
      PBProgressSimple(
        progress: $progress,
        progressColor: .pbPrimary
      )
    }
  }
  var settingValueView: some View {
    VStack(alignment: .leading) {
      PBProgressSimple(
        progress: $progress1,
        progressColor: .pbPrimary
      )
      PBProgressSimple(
        value: $value,
        maxValue: 10,
        progressColor: .pbPrimary,
        variant: .settingValue
      )
    }
  }
}
#Preview {
  registerFonts()
  return ProgressSimpleCatalog()
}
