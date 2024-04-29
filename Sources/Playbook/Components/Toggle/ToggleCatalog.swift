//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ToggleCatalog.swift
//

import SwiftUI

public struct ToggleCatalog: View {
  @State private var checked: Bool = true
  @State private var checked1: Bool = false
  @State private var checked2: Bool = false
  @State private var checked3: Bool = false
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          VStack(spacing: Spacing.small) {
            PBToggle(checked: $checked)
            PBToggle(checked: $checked1)
          }
        }

        PBDoc(title: "Name") {
          VStack(spacing: Spacing.small) {
            PBToggle(label: "car", checked: $checked2)
            PBToggle(label: "bike", checked: $checked3)
          }
        }
      }
      .padding(Spacing.medium)
    }
    .navigationTitle("Toggle")
  }
}

struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    ToggleCatalog()
  }
}
