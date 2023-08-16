//
//  CheckboxCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
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
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Checkbox")
  }
}
