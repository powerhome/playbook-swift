//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBToggle.swift
//


import SwiftUI

public struct PBToggle: View {
  @State var isHovering: Bool = false
  @State var label: String?
  @Binding var checked: Bool
  public init(
    label: String? = nil,
    checked: Binding<Bool> = .constant(false)
  ) {
    self.label = label
    self._checked = checked
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.none) {
      if label != nil {
        Text(label!)
          .foregroundColor(.text(.light))
          .padding(.trailing)
          .pbFont(.caption)
      }
      ZStack {
        RoundedRectangle(cornerRadius: 22)
          .strokeBorder(strokeColor(isHovering: isHovering), lineWidth: 3)
          .foregroundColor(backgroundColor)
          .background(
            RoundedRectangle(cornerRadius: 22)
              .foregroundColor(backgroundColor)
          )
          .frame(width: 50, height: 28, alignment: .center)

        Circle()
          .foregroundColor(circleColor(isHovering: isHovering))
          .frame(width: 18, height: 18, alignment: .center)
          .offset(x: checked ? 11 : -11, y: 0)
      }
      .onHover(disabled: false) { hovering in
        withAnimation {
          isHovering = hovering
        }
      }
      .onTapGesture {
        withAnimation {
          checked.toggle()
        }
      }
    }
  }
}

public extension PBToggle {
  func strokeColor(isHovering: Bool) -> Color {
    checked || isHovering ? .pbPrimary : .border
  }

  func circleColor(isHovering: Bool) -> Color {
    if checked {
      return .white
    }
    if isHovering {
      return .pbPrimary
    }
    return .border
  }

  var backgroundColor: Color {
    if checked {
      return .pbPrimary
    }
    return .clear
  }
}

struct PBToggle_Previews: PreviewProvider {
  static var previews: some View {
    return ToggleCatalog()
  }
}
