//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDialogActionView.swift
//

import SwiftUI

struct PBDialogActionView: View {
  let isStacked: Bool
  let confirmButton: (String, (() -> Void))?
  let cancelButton: (String, (() -> Void)?)?
  let variant: DialogVariant?
  let isButtonFullWidth: Bool?
  let buttonSize: PBButton.Size
  let isLoading: Bool

  public init(
    isStacked: Bool = false,
    confirmButton: (String, (() -> Void))? = nil,
    cancelButton: (String, (() -> Void)?)? = nil,
    variant: DialogVariant? = nil,
    isButtonFullWidth: Bool? = false,
    buttonSize: PBButton.Size = .medium,
    isLoading: Bool = false
  ) {
    self.isStacked = isStacked
    self.confirmButton = confirmButton
    self.cancelButton = cancelButton
    self.variant = variant
    self.isButtonFullWidth = isButtonFullWidth
    self.buttonSize = buttonSize
    self.isLoading = isLoading
  }

  var body: some View {
    AdaptiveStack(isStacked: isStacked) {
      if let confirmButton = confirmButton {
        PBButton(
          fullWidth: isButtonFullWidth ?? false, 
          size: buttonSize, 
          title: confirmButton.0,
          isLoading: isLoading,
          action: confirmButton.1
        ).padding(.bottom, Spacing.xxSmall)
      }

      if let cancelButton = cancelButton {
        if !isStacked {
          Spacer()
        }

        PBButton(
          fullWidth: isButtonFullWidth ?? false,
          variant: (isStacked || variant != .default ? .secondary : .link),
          size: buttonSize,
          title: cancelButton.0,
          isLoading: isLoading,
          action: cancelButton.1 ?? {}
        )
        .padding(.top, isStacked ? 5 : 0)
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.bottom, Spacing.small)
    .padding(.leading, Spacing.small)
    .padding(.trailing, Spacing.small)
   
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
