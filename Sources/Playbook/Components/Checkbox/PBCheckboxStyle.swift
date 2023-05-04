//
//  PBCheckboxStyle.swift
//
//
//  Created by Gavin Huang on 5/2/23.
//

import SwiftUI

public struct PBCheckboxStyle: ToggleStyle {
  @Binding var checked: Bool
  var checkboxType: PBCheckbox.CheckboxType
  let action: (() -> Void)?

  public func makeBody(configuration: Configuration) -> some View {
    HStack {
      ZStack {
        RoundedRectangle(cornerRadius: 4)
          .strokeBorder(borderColor, lineWidth: 2)
          .background(backgroundColor)
          .clipShape(RoundedRectangle(cornerRadius: 4))
          .frame(width: 22, height: 22)

        switch (checked, checkboxType) {
        case (true, .indeterminate):
          PBIcon.fontAwesome(.minus, size: .small)
            .foregroundColor(.white)
        case (false, _): EmptyView()
        default:
          PBIcon.fontAwesome(.check, size: .small)
            .foregroundColor(.white)
        }
      }

      configuration.label
        .foregroundColor(checkboxType == .error ? .status(.error) : .text(.default))
        .pbFont(.body())
    }
    .frame(minHeight: 22)
    .contentShape(Rectangle())
    .onTapGesture {
      checked.toggle()
      action?()
    }

    var borderColor: Color {
      switch (checkboxType, checked) {
      case (.default, true), (.error, true), (.indeterminate, true): return .pbPrimary
      case (.error, false): return .status(.error)
      default: return .border
      }
    }

    var backgroundColor: Color {
      checked ? .pbPrimary : .clear
    }
  }
}
