//
//  PBCheckbox.swift
//
//
//  Created by Everton Cunha on 15/06/22.
//

import SwiftUI

public struct PBCheckbox: View {
  @State var isChecked: Bool
  @State var error: Bool
  var title: String?
  let action: (() -> Void)?

  public init(
    isChecked: Bool = false,
    error: Bool = false,
    title: String? = nil,
    action: (() -> Void)? = {}
  ) {
    self.isChecked = isChecked
    self.error = error
    self.title = title
    self.action = action
  }

  public var body: some View {
    Toggle(isOn: $isChecked) {
      if let title = title {
        Text(title)
      }
    }
    .toggleStyle(
      PBCheckboxToggleStyle(
        isChecked: isChecked,
        error: error,
        action: action
      )
    )
  }
}

struct PBCheckbox_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return VStack {
      PBCheckbox(isChecked: false, title: "Test", action: {})
      PBCheckbox(isChecked: false, error: true, title: "Test", action: {})
    }
  }
}
