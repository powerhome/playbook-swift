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
  @State private var trackerProgress: Int = 1
  @State private var trackerProgress1: Int = 1
  
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
      Button(action: {
        progress += 1
        progress1 += 1
        trackerProgress += 1
        trackerProgress1 += 1
      }) {
        Text("Submit")
          .padding()
          .background(Color.blue)
          .foregroundColor(.white)
          .cornerRadius(8)
      }
      .padding(.vertical, 50)
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
        label: "Step",
        showLabelIndex: true,
        progress: $progress1
      )
    }
    .padding(.bottom, 30)
  }
  var verticalView: some View {
    HStack(spacing: Spacing.xLarge) {
      PBProgressStep(
        pillHeight: 30,
        variant: .vertical,
        progress: $progress
      )
      PBProgressStep(
        label: "Child",
        pillHeight: 30,
        variant: .vertical,
        progress: $progress
      )
    }
  }
  var trackerView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBProgressStep(
        steps: 2,
        variant: .tracker,
        customLabel: ["Ordered", "Shipped", "Delivered"],
        progress: $trackerProgress
      )
      PBProgressStep(
        steps: 3,
        variant: .tracker,
        progress: $trackerProgress1
      )
      
    }
  }
}
#Preview {
  registerFonts()
  return ProgressStepCatalog()
}
