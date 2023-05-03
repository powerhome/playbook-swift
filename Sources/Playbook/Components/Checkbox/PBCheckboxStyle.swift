//
//  PBCheckboxStyle.swift
//
//
//  Created by Gavin Huang on 5/2/23.
//

import SwiftUI

public struct PBCheckboxToggleStyle: ToggleStyle {
  var isChecked: Bool
  var error: Bool
  let action: (() -> Void)?

  public func makeBody(configuration: Configuration) -> some View {
    var borderColor: Color {
      if isChecked {
        return .pbPrimary
      } else if error {
        return .status(.error)
      } else {
        return .border
      }
    }

    var backgroundColor: Color {
      isChecked ? .pbPrimary : .clear
    }

    HStack {
      ZStack {
        RoundedRectangle(cornerRadius: 4)
          .strokeBorder(borderColor, lineWidth: 2)
          .background(backgroundColor)
          .clipShape(RoundedRectangle(cornerRadius: 4))
          .frame(width: 22, height: 22)

        if isChecked {
          PBIcon.fontAwesome(.check, size: .small)
            .foregroundColor(.white)
        }
      }

      configuration.label
        .foregroundColor(error ? .status(.error) : .text(.default))
        .pbFont(.body())
    }
    .frame(minHeight: 22)
    .onTapGesture {
      configuration.isOn.toggle()
    }
  }
}
