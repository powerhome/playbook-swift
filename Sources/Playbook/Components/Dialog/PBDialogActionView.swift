//
//  PBDialogActionView.swift
//  
//
//  Created by Isis Silva on 03/04/23.
//

import SwiftUI

struct PBDialogActionView: View {
  let isStacked: Bool
  let confirmButton: (String, (() -> Void))?
  let cancelButton: (String, (() -> Void)?)?

  public init(
    isStacked: Bool = false,
    confirmButton: (String, (() -> Void))? = nil,
    cancelButton: (String, (() -> Void)?)? = nil
  ) {
    self.isStacked = isStacked
    self.confirmButton = confirmButton
    self.cancelButton = cancelButton
  }

  var body: some View {
    AdaptiveStack(isStacked: isStacked) {
      if let confirmButton = confirmButton {
        PBButton(
          title: confirmButton.0,
          action: confirmButton.1
        )
      }

      if let cancelButton = cancelButton {
        if !isStacked {
          Spacer()
        }

        PBButton(
          variant: (isStacked ? .secondary : .link),
          title: cancelButton.0,
          action: cancelButton.1 ?? {}
        )
        .padding(.top, isStacked ? -8 : 0)
      }
    }
    .frame(maxWidth: .infinity)
  }
}

struct PBDialogActionView_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return List {
      PBDialogActionView(
        confirmButton: ("Okay", {}),
        cancelButton: ("Cancel", {})
      )
      .listRowSeparator(.hidden)

      PBDialogActionView(
        isStacked: true,
        confirmButton: ("Yes, Action", {}),
        cancelButton: ("No, Cancel", {})
      )
      .listRowSeparator(.hidden)

      PBDialogActionView(
        confirmButton: ("Okay", {})
      )
    }
  }
}
