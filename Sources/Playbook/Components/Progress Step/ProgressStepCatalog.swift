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
  @State private var hasIcon: Bool = false
  @State private var isActive = [false, true, false]
  @State private var isComplete = [true, false, false]
  @State private var isActive1 = [false, true, false]
  @State private var isComplete1 = [true, false, false]
  public var body: some View {
    PBDocStack(title: "Progress Step", spacing: Spacing.medium) {
      PBDoc(title: "Default") {
        defaultView
      }
    }
  }
}

extension ProgressStepCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBProgressStep(
        isActive: $isActive,
        isComplete: $isComplete
      )
      PBProgressStep(
        label: "Step",
        showLabelIndex: true,
        hasIcon: $hasIcon,
        isActive: $isActive1,
        isComplete: $isComplete1
      )
    }
    .padding(.bottom, 30)
  }
}
#Preview {
  registerFonts()
  return ProgressStepCatalog()
}
