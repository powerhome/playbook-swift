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
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          PBCheckbox(checked: false, text: "Unchecked", action: {})
            .padding(.bottom, Spacing.small)

          PBCheckbox(checked: true, text: "Checked", action: {})
        }

        PBDoc(title: "Error") {
          PBCheckbox(
            checked: false,
            checkboxType: .error,
            text: "Error",
            action: {}
          )
        }

        PBDoc(title: "Indeterminate") {
          PBCheckbox(
            checked: true,
            checkboxType: .indeterminate,
            text: "Indeterminate",
            action: {}
          )
        }
      }
      .padding(Spacing.medium)
    }
    .navigationTitle("Checkbox")
  }
}
