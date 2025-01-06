//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  TypeaheadPill.swift
//

import SwiftUI

struct TypeaheadPill: View {
  @Environment(\.active) var isActive: Bool
  @Environment(\.focus) var isFocus: Bool
  @Environment(\.hovering) var hovering: Bool
  @State private var isHovering: Bool = false
  private var shape =  Capsule()
  let icon: FontAwesome?
  let text: String
  let closeAction: (() -> Void)?

  init(_ text: String, icon: FontAwesome? = nil, closeAction: (() -> Void)? = nil) {
    self.text = text
    self.icon = icon
    self.closeAction = closeAction
  }

    var body: some View {
      HStack(spacing: Spacing.xSmall) {
        if let icon = icon {
          PBIcon.fontAwesome(icon, size: .xSmall)
            .foregroundStyle(Color.text(.light))
        }
        Text(text)
              .font(.custom(Font.ProximaNova.bold.rawValue, size: 14))
        PBIcon(FontAwesome.times, size: .xSmall)
      }
      .foregroundStyle(Color.text(.default))
      .padding(.vertical, verticalPadding)
      .padding(.horizontal, horizontalPadding)
      .background(backgroundColor)
      .clipShape(shape)
      .background(
        shape
          .stroke(lineWidth: borderWidth)
          .foregroundStyle(borderColor)
      )
      .onHover(disabled: false) { hovering in
        isHovering = hovering
      }
    }
}

private extension TypeaheadPill {
  var verticalPadding: CGFloat {
    isFocus ? 3 : 4
  }
  
  var horizontalPadding: CGFloat {
    isFocus ? 11 : 12
  }

  var backgroundColor: Color {
    if isActive {
      return .active
    } else if isHovering {
      return .hover
    } else {
      return .white
    }
  }

  var borderWidth: CGFloat {
    isFocus ? 2 : 1
  }

  var borderColor: Color {
    isFocus ? .pbPrimary : .border
  }
}

#Preview {
  registerFonts()
  return TypeaheadPillCatalog()
}
