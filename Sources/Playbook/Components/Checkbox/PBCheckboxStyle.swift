//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBCheckboxStyle.swift
//

import SwiftUI

public struct PBCheckboxStyle: ToggleStyle {
  @Binding var checked: Bool
  @State private var isHovering = false
  var checkboxType: PBCheckbox.CheckboxType
  let action: (() -> Void)?
  @Environment(\.colorScheme) var colorScheme
  public func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: Spacing.xSmall) {
      ZStack {
        RoundedRectangle(cornerRadius: 4)
          .strokeBorder(_borderColor, lineWidth: 2)
          .background(backgroundColor)
          .background(isHovering ? Color.hover : Color.clear)
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
        .pbFont(.body)
    }
    .frame(minHeight: 22)
    .contentShape(Rectangle())
    .onHover(disabled: false) {
      isHovering = $0
    }
    .onTapGesture {
      checked.toggle()
      action?()
    }
  }

  var borderColor: Color {
    switch (checkboxType, checked) {
    case (.default, true), (.error, true), (.indeterminate, true): return .pbPrimary
    case (.error, false): return .status(.error)
    default: return Color.border
    }
  }
  
  var _borderColor: Color {
    switch colorScheme {
    case .light: return borderColor
    case .dark: return checked == false && checkboxType != .error ? Color(hex: "#e4e8f0") : borderColor
    default:
      return borderColor
    }
  }

  var backgroundColor: Color {
    checked ? .pbPrimary : .clear
  }
}
