//
//  SwiftUIView.swift
//
//
//  Created by Nick Amantia on 7/6/23.
//

import SwiftUI

public struct PBToggle: View {
  @State var isHovering: Bool = false
  @State var label: String?
  @State var checked: Bool

  public init(
    label: String? = nil,
    checked: Bool
  ) {
    self.label = label
    self.checked = checked
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.none) {
      if label != nil {
        Text(label!).foregroundColor(.text(.light)).padding(.trailing).pbFont(.caption)
      }
      ZStack {
        RoundedRectangle(cornerRadius: 22)
          .strokeBorder(strokeColor(isHovering: isHovering), lineWidth: 3)
          .foregroundColor(backgroundColor)
          .background(
            RoundedRectangle(cornerRadius: 22)
              .foregroundColor(backgroundColor)
          )
          .frame(width: 55, height: 30, alignment: .center)

        Circle()
          .foregroundColor(circleColor(isHovering: isHovering))
          .frame(width: 20, height: 20, alignment: .center)
          .offset(x: checked ? 12 : -12, y: 0)
      }
      .onHover { hovering in
        withAnimation {
          isHovering = hovering
        }
      }
      .onTapGesture {
        withAnimation {
          checked = !checked
        }
      }
    }
  }
}

public extension PBToggle {
  func strokeColor(isHovering: Bool) -> Color {
    checked || isHovering ? .pbPrimary : .status(.neutral)
  }

  func circleColor(isHovering: Bool) -> Color {
    if checked {
      return .white
    }
    if isHovering {
      return .pbPrimary
    }
    return .status(.neutral)
  }

  var backgroundColor: Color {
    if checked {
      return .pbPrimary
    }
    return .clear
  }
}

struct PBToggleStyle_Previews: PreviewProvider {
  static var previews: some View {
    return ToggleCatalog()
      .background(Color.card)
  }
}
