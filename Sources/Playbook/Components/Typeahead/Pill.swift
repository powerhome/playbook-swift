//
//  Pill.swift
//  
//
//  Created by Isis Silva on 13/11/23.
//

import SwiftUI

struct Pill: View {
  private var shape =  Capsule()
  @Environment (\.active) var isActive: Bool
  @Environment (\.focus) var isFocus: Bool
  @Environment(\.hovering) var hovering: Bool
  @State private var isHovering: Bool = false
  let icon: FontAwesome? = nil
  

    var body: some View {
      HStack(spacing: Spacing.xSmall) {
        if let icon = icon {
          PBIcon.fontAwesome(icon)
        }

        Text("Default")
          .font(.custom(ProximaNova.bold.rawValue, size: 14))
          .foregroundStyle(Color.text(.default))

        PBIcon(FontAwesome.times)
      }
      .padding(.vertical, Spacing.xSmall)
      .padding(.horizontal, Spacing.small )
      .background(backgroundColor)
      .clipShape(shape)
      .overlay(
        shape
          .stroke(lineWidth: borderWidth)
          .foregroundStyle(borderColor)
      )
      .onHover { hovering in
        isHovering = hovering
      }
    }
}

private extension Pill {
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
  return VStack(spacing: Spacing.small) {
    Pill()

    Pill()
      .environment(\.focus, true)

    Pill()
      .environment(\.active, true)

    Pill()
      .environment(\.hovering, true)

    Pill()
      .environment(\.hovering, true)
      .environment(\.focus, true)

    Pill()
      .environment(\.hovering, true)
      .environment(\.active, true)
      .environment(\.focus, true)
  }
}
