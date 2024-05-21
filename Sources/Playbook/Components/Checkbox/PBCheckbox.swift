//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBCheckbox.swift
//

import SwiftUI

public struct PBCheckbox: View {
  @Binding var checked: Bool
  @State var checkboxType: CheckboxType
  var text: String?
  let action: (() -> Void)?
  
  public init(
    checked: Binding<Bool> = .constant(false),
    checkboxType: CheckboxType = .default,
    text: String? = nil,
    action: (() -> Void)? = {}
  ) {
    self._checked = checked
    self.checkboxType = checkboxType
    self.text = text
    self.action = action
   
  }

  public var body: some View {
    Toggle(isOn: $checked) {
      if let text = text {
        Text(text)
      }
    }
    .toggleStyle(
      PBCheckboxStyle(
        checked: $checked,
        checkboxType: checkboxType,
        action: action
      )
    )
  }

  public enum CheckboxType {
    case `default`, error, indeterminate
  }
}

public struct PBCheckbox_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return CheckboxCatalog()
  }
}
