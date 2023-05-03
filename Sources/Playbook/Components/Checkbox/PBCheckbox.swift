//
//  PBCheckbox.swift
//
//
//  Created by Everton Cunha on 15/06/22.
//

import SwiftUI

public struct PBCheckbox: View {
  @State var isChecked: Bool

  public var body: some View {
    VStack {
      Toggle(isOn: $isChecked) {
        Text("Test")
      }
      .toggleStyle(PBCheckboxToggleStyle())
    }
  }
}

struct PBCheckbox_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return VStack {
      PBCheckbox(isChecked: false)
    }
  }
}
