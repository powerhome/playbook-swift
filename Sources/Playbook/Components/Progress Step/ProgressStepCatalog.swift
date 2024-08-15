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
  public var body: some View {
    PBDocStack(title: "Progress Step", spacing: Spacing.medium) {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Vertical") {
        verticalView
      }
      PBDoc(title: "Tracker") {
        trackerView
          .padding(.bottom, 50)
      }
    }
  }
}
extension ProgressStepCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBProgressStep(
        steps: 3,
        progress: .constant(1),
        icon: nil
      )
      PBProgressStep(
        steps: 5,
        progress: .constant(2),
        icon: nil,
        label: "Step",
        showLabelIndex: true
      )
      PBProgressStep(
        steps: 3,
        progress: .constant(3),
        label: "Step",
        showLabelIndex: true
      )
    }
    .padding(.bottom, 30)
  }
  var verticalView: some View {
    HStack(spacing: Spacing.xLarge) {
      PBProgressStep(
        progress: .constant(1),
        pillHeight: 30,
        variant: .vertical
      )
      PBProgressStep(
        progress: .constant(1),
        label: "Child",
        pillHeight: 30,
        variant: .vertical
      )
    }
  }
  var trackerView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBProgressStep(
        steps: 3,
        progress: .constant(2),
        variant: .tracker,
        customLabel: ["Ordered", "Shipped", "Delivered"]
      )
      PBProgressStep(
        steps: 4,
        progress: .constant(3),
        variant: .tracker
      )
      
    }
  }
}

#Preview {
  registerFonts()
  return ProgressStepCatalog()
}
