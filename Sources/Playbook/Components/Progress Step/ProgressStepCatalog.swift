//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ProgressStepCatalog.swift
//

import SwiftUI

public struct ProgressStepCatalog: View {
  @State private var progress: Int = 1
  @State private var progress1: Int = 1
  public var body: some View {
    PBDocStack(title: "Progress Step", spacing: Spacing.medium) {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Vertical") {
        verticalView
      }
    }
  }
}

extension ProgressStepCatalog {
  var defaultView: some View {
      VStack(alignment: .leading, spacing: Spacing.medium) {
        PBProgressStep(
          progress: $progress
        )
        PBProgressStep(
          hasIcon: false,
          label: "Step",
          showLabelIndex: true,
          progress: $progress1
        )
      }
      .padding(.bottom, 30)
  }
  var verticalView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBProgressStep(
        variant: .vertical,
        progress: $progress
      )
      PBProgressStep(
        hasIcon: false,
        variant: .vertical,
        progress: $progress
      )
      PBProgressStep(
        hasIcon: false,
        label: "Child",
        variant: .vertical,
        progress: $progress
      )
    }
  }
}
#Preview {
  registerFonts()
  return ProgressStepCatalog()
}
