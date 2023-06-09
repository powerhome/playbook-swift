//
//  CheckboxCatalog.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct CheckboxCatalog: View {
  public var body: some View {
    VStack(alignment: .leading) {
      PBCheckbox(checked: false, text: "Unchecked", action: {})
      PBCheckbox(checked: true, text: "Checked", action: {})
      PBCheckbox(
        checked: false,
        checkboxType: .error,
        text: "Error",
        action: {}
      )
      PBCheckbox(
        checked: true,
        checkboxType: .indeterminate,
        text: "Indeterminate",
        action: {}
      )
    }
    .navigationTitle("Checkbox")
  }
}
