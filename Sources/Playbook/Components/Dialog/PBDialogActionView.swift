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
  let confirmButton: PBButton?
  let cancelButton: PBButton?
  let variant: DialogVariant?
  let isButtonFullWidth: Bool?
  let buttonSize: PBButton.Size
  let isLoading: Bool

  public init(
    isStacked: Bool = false,
    cancelButton: PBButton? = PBButton(variant: .primary, title: "Cancel", action: nil),
    confirmButton: PBButton? = PBButton(variant: .secondary, title: "Cancel", action: nil),
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
      confirmButton
          .padding(.bottom, Spacing.xxSmall)
      }

      if let cancelButton = cancelButton {
        if !isStacked {
          Spacer()
        }

      cancelButton
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
        cancelButton: PBButton(variant: .primary, title: "Cancel", action: nil), 
        confirmButton: PBButton(variant: .secondary, title: "Confirm", action: nil)
      )
      .listRowSeparator(.hidden)

      PBDialogActionView(
        isStacked: true,
        cancelButton: PBButton(variant: .primary, title: "Cancel", action: nil), 
        confirmButton: PBButton(variant: .secondary, title: "Confirm", action: nil)
      )
      .listRowSeparator(.hidden)

      PBDialogActionView(
        confirmButton: PBButton(variant: .secondary, title: "Confirm", action: nil)
      )
    }
  }
}
