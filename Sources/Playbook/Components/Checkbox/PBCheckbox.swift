//
//  PBCheckbox.swift
//
//
//  Created by Everton Cunha on 15/06/22.
//

import SwiftUI

public struct PBCheckbox: View {
  @State var checked: Bool
  @State var error: Bool
  @State var indeterminate: Bool
  var text: String?
  let action: (() -> Void)?

  public init(
    checked: Bool = false,
    error: Bool = false,
    indeterminate: Bool = false,
    text: String? = nil,
    action: (() -> Void)? = {}
  ) {
    self.checked = checked
    self.error = error
    self.indeterminate = indeterminate
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
      PBCheckboxToggleStyle(
        checked: $checked,
        error: error,
        indeterminate: indeterminate,
        action: action
      )
    )
  }
}

struct PBCheckbox_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return VStack {
      PBCheckbox(checked: false, text: "Unchecked", action: {})
      PBCheckbox(checked: true, text: "Checked", action: {})
      PBCheckbox(checked: false, error: true, text: "Error", action: {})
      PBCheckbox(checked: true, indeterminate: true, text: "Indeterminate", action: {})
    }
  }
}
