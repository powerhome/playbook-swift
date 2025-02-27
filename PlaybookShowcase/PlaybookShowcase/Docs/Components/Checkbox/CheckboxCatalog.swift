//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  CheckboxCatalog.swift
//

import SwiftUI
import Playbook

public struct CheckboxCatalog: View {
  @State private var checked: Bool = false
  @State private var checked1: Bool = true
  @State private var checked2: Bool = false
  @State private var checked3: Bool = true
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
        checked: $checked,
        text: "Unchecked",
        action: {}
      )
      PBCheckbox(
        checked: $checked1,
        text: "Checked",
        action: {}
      )
    }
  }
  var errorView: some View {
    PBCheckbox(
      checked: $checked2,
      checkboxType: .error,
      text: "Error",
      action: {}
    )
  }
  var indeterminateView: some View {
    PBCheckbox(
      checked: $checked3,
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
