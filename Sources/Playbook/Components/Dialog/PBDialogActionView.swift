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
  let confirmButtonStyle: PBButtonStyle
  let cancelButton: (String, (() -> Void)?)?
  let cancelButtonStyle: PBButtonStyle

  public init(
    isStacked: Bool = false,
    confirmButton: (String, (() -> Void))? = nil,
    confirmButtonStyle: PBButtonStyle = PBButtonStyle(variant: .primary),
    cancelButton: (String, (() -> Void)?)? = nil,
    cancelButtonStyle: PBButtonStyle = PBButtonStyle(variant: .link)
  ) {
    self.isStacked = isStacked
    self.confirmButton = confirmButton
    self.confirmButtonStyle = confirmButtonStyle
    self.cancelButton = cancelButton
    self.cancelButtonStyle = cancelButtonStyle
  }

  var body: some View {
    AdaptiveStack(isStacked: isStacked) {
      if let confirmButton = confirmButton {
        Button {
          confirmButton.1()
        } label: {
          stackedLabel(confirmButton.0)
        }
        .buttonStyle(confirmButtonStyle)
      }

      if let cancelButton = cancelButton {
        if !isStacked {
          Spacer()
        }
        Button {
          (cancelButton.1 ?? {})()
        } label: {
          stackedLabel(cancelButton.0)
        }
        .buttonStyle(cancelButtonStyle)
      }
    }
    .frame(maxWidth: .infinity)
  }

  @ViewBuilder
  func stackedLabel(_ text: String) -> some View {
    if isStacked {
      Text(text).frame(maxWidth: .infinity)
    } else {
      Text(text)
    }
  }
}

struct PBDialogActionView_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return List {
      PBDialogActionView(
        confirmButton: ("Okay", {}),
        confirmButtonStyle: PBButtonStyle(variant: .primary),
        cancelButton: ("Cancel", {}),
        cancelButtonStyle: PBButtonStyle(variant: .link)
      )

      PBDialogActionView(
        isStacked: true,
        confirmButton: ("Yes, Action", {}),
        confirmButtonStyle: PBButtonStyle(variant: .primary),
        cancelButton: ("No, Cancel", {}),
        cancelButtonStyle: PBButtonStyle(variant: .secondary)
      )

      PBDialogActionView(
        confirmButton: ("Okay", {}),
        confirmButtonStyle: PBButtonStyle(variant: .primary)
      )
    }
  }
}
