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
  @State private var isActive = [false, true, false]
    @State private var isComplete = [true, false, false]
    @State private var isInactive = [false, false, true]
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
    VStack(alignment: .leading, spacing: Spacing.small) {
        PBProgressStep(
          isActive: $isActive,
          isComplete: $isComplete,
          isInactive: $isInactive
        )
      
    }
  }
}
#Preview {
  registerFonts()
   return ProgressStepCatalog()
}
