//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  CheckboxCatalog.swift
//

import SwiftUI

public struct CheckboxCatalog: View {
  @State private var checked: Bool = false
  @State private var checked1: Bool = true
  @State private var checked2: Bool = false
  @State private var checked3: Bool = true
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          PBCheckbox(checked: $checked, text: "Unchecked", action: {})
            .padding(.bottom, Spacing.small)

          PBCheckbox(checked: $checked1, text: "Checked", action: {})
        }

        PBDoc(title: "Error") {
          PBCheckbox(
            checked: $checked2,
            checkboxType: .error,
            text: "Error",
            action: {}
          )
        }

        PBDoc(title: "Indeterminate") {
          PBCheckbox(
            checked: $checked3,
            checkboxType: .indeterminate,
            text: "Indeterminate",
            action: {}
          )
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Checkbox")
  }
}
