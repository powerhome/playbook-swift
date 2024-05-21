//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBRadioStyle.swift
//

import SwiftUI

public struct PBRadioStyle: ToggleStyle {
  @Environment(\.colorScheme) var colorScheme
  @State var isHovering: Bool = false
  var labelsHidden: Bool

  public init(labelsHidden: Bool = false) {
    self.labelsHidden = labelsHidden
  }

  public func makeBody(configuration: Configuration) -> some View {
    HStack(alignment: .center, spacing: 10) {
      ZStack {
        RoundedRectangle(cornerRadius: 4)
          .strokeBorder(configuration.isOn || isHovering ? Color.pbPrimary : Color.border, lineWidth: 3)
          .foregroundColor(configuration.isOn ? .pbPrimary : .clear)
          .background(
            RoundedRectangle(cornerRadius: 4)
              .foregroundColor(configuration.isOn ? .pbPrimary : .clear)
          )
          .frame(width: 30, height: 30, alignment: .center)

        Button {
          withAnimation(.easeInOut(duration: 0.25)) {
            configuration.isOn.toggle()
          }
        } label: {
          PBIcon.fontAwesome(.check, size: .x1)
            .foregroundColor(configuration.isOn
              ? (colorScheme == .light
                ? .white
                : .text(.default))
              : .background(.default))
            .opacity(configuration.isOn ? 1 : 0.05)
        }
        .buttonStyle(.borderless)
      }
      .onHover(disabled: false) { hovering in
        withAnimation {
          isHovering = hovering
        }
      }

      if !labelsHidden {
        configuration.label
          .foregroundColor(.text(.light))
          .pbFont(.body)
      }
    }
  }
}

public struct PBRadioStyle_Previews: PreviewProvider {
  public static var previews: some View {
    VStack(alignment: .leading, spacing: 10) {
      Toggle("Checked", isOn: .constant(true))
        .toggleStyle(PBRadioStyle())
      Toggle("Unchecked", isOn: .constant(false))
        .toggleStyle(PBRadioStyle())
    }
  }
}
