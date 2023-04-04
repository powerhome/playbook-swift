//
//  DialogActionView.swift
//  
//
//  Created by Isis Silva on 03/04/23.
//

import SwiftUI

struct DialogActionView: View {
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

struct DialogActionView_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return List {
      DialogActionView(
        confirmButton: ("Okay", {}),
        confirmButtonStyle: PBButtonStyle(variant: .primary),
        cancelButton: ("Cancel", {}),
        cancelButtonStyle: PBButtonStyle(variant: .link)
      )

      DialogActionView(
        isStacked: true,
        confirmButton: ("Yes, Action", {}),
        confirmButtonStyle: PBButtonStyle(variant: .primary),
        cancelButton: ("No, Cancel", {}),
        cancelButtonStyle: PBButtonStyle(variant: .secondary)
      )

      DialogActionView(
        confirmButton: ("Okay", {}),
        confirmButtonStyle: PBButtonStyle(variant: .primary)
      )
    }
  }
}
