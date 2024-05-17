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
    PBDocStack(title: "Checkbox") {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Error") {
        errorView
      }

      PBDoc(title: "Indeterminate") {
        indeterminateView
      }
    }
  }
}

extension CheckboxCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBCheckbox(
        checked: false,
        text: "Unchecked",
        action: {}
      )
      PBCheckbox(
        checked: true,
        text: "Checked",
        action: {}
      )
    }
  }
  var errorView: some View {
    PBCheckbox(
      checked: false,
      checkboxType: .error,
      text: "Error",
      action: {}
    )
  }
  var indeterminateView: some View {
    PBCheckbox(
      checked: true,
      checkboxType: .indeterminate,
      text: "Indeterminate",
      action: {}
    )
  }
}

#Preview {
  registerFonts()
  return CheckboxCatalog()
}
