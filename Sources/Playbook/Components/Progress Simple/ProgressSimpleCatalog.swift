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
  @State private var progress2: Double = 0.64
  @State private var progress3: Double = 0.9
  @State private var progress4: Double = 0.1
  @State private var progress5: Double = 0.4
  @State private var progress6: Double = 0.68
  @State private var value: Int = 2
  public var body: some View {
    PBDocStack(title: "Progress Simple", spacing: Spacing.medium) {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Setting Values") {
        settingValueView
      }
      PBDoc(title: "Variants") {
        progressColorView
      }
    }
  }
}

public extension ProgressSimpleCatalog {
  var defaultView: some View {
    VStack(alignment: .leading) {
      PBProgressSimple(
        progress: $progress
      )
    }
  }
  var settingValueView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBProgressSimple(
        progress: $progress1
      )
      PBProgressSimple(
        value: $value,
        maxValue: 10,
        variant: .settingValue
      )
    }
  }
  var progressColorView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBProgressSimple(
        progress: $progress2,
        progressColor: .pbPrimary
      )
      PBProgressSimple(
        progress: $progress3,
        progressColor: .status(.success)
      )
      PBProgressSimple(
        progress: $progress4,
        progressColor: .status(.error)
      )
      PBProgressSimple(
        progress: $progress5,
        progressColor: .status(.warning)
      )
      PBProgressSimple(
        progress: $progress6,
        progressColor: .status(.neutral)
      )
    }
  }
}
#Preview {
  registerFonts()
  return ProgressSimpleCatalog()
}
