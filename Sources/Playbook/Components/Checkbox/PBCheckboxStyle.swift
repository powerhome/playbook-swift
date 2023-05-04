//
//  PBCheckboxStyle.swift
//
//
//  Created by Gavin Huang on 5/2/23.
//

import SwiftUI

public struct PBCheckboxToggleStyle: ToggleStyle {
  var checked: Bool
  var error: Bool
  var indeterminate: Bool
  let action: (() -> Void)?

  public func makeBody(configuration: Configuration) -> some View {
    var borderColor: Color {
      if checked {
        return .pbPrimary
      } else if error {
        return .status(.error)
      } else {
        return .border
      }
    }

    var backgroundColor: Color {
      checked ? .pbPrimary : .clear
    }

    HStack {
      ZStack {
        RoundedRectangle(cornerRadius: 4)
          .strokeBorder(borderColor, lineWidth: 2)
          .background(backgroundColor)
          .clipShape(RoundedRectangle(cornerRadius: 4))
          .frame(width: 22, height: 22)

        if checked && !indeterminate {
          PBIcon.fontAwesome(.check, size: .small)
            .foregroundColor(.white)
        }

        if indeterminate {
          PBIcon.fontAwesome(.minus, size: .small)
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
