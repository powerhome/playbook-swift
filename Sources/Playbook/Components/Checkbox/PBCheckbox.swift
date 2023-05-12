//
//  PBCheckbox.swift
//
//
//  Created by Everton Cunha on 15/06/22.
//

import SwiftUI

public struct PBCheckbox: View {
  @State var checked: Bool
  @State var checkboxType: CheckboxType
  var text: String?
  let action: (() -> Void)?

  public init(
    checked: Bool = false,
    checkboxType: CheckboxType = .default,
    text: String? = nil,
    action: (() -> Void)? = {}
  ) {
    self.checked = checked
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

struct PBCheckbox_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return VStack {
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
  }
}
