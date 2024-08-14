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
  @State private var progress2: Double = 0.40
  @State private var progress3: Double = 0.64
  @State private var progress4: Double = 0.9
  @State private var progress5: Double = 0.1
  @State private var progress6: Double = 0.4
  @State private var progress7: Double = 0.68
  @State private var progress8: Double = 0.45
  @State private var progress9: Double = 0.45
  @State private var progress10: Double = 0.45
  @State private var value: Int = 2
  
  public var body: some View {
    PBDocStack(title: "Progress Simple", spacing: Spacing.medium) {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Setting Values") {
        settingValueView
      }
      PBDoc(title: "Progress Bar Width") {
        progressWidthView
      }
      PBDoc(title: "Variants") {
        progressColorView
      }
      PBDoc(title: "Align") {
        alignmentView
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
  
  var progressWidthView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBProgressSimple(
        progress: $progress2,
        progressColor: .pbPrimary,
        progressWidth: 100
      )
    }
  }
  
  var progressColorView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBProgressSimple(
        progress: $progress3,
        progressColor: .pbPrimary
      )
      PBProgressSimple(
        progress: $progress4,
        progressColor: .status(.success)
      )
      PBProgressSimple(
        progress: $progress5,
        progressColor: .status(.error)
      )
      PBProgressSimple(
        progress: $progress6,
        progressColor: .status(.warning)
      )
      PBProgressSimple(
        progress: $progress7,
        progressColor: .status(.neutral)
      )
    }
  }
  
  var alignmentView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      HStack {
        PBProgressSimple(
          progress: $progress8,
          progressWidth: 100
        )
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      HStack {
        PBProgressSimple(
          progress: $progress9,
          progressWidth: 100
        )
      }
      .frame(maxWidth: .infinity, alignment: .center)
      HStack {
        PBProgressSimple(
          progress: $progress10,
          progressWidth: 100
        )
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
}

#Preview {
  registerFonts()
  return ProgressSimpleCatalog()
}
