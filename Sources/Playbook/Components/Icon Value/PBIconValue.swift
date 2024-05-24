//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBIconValue.swift
//

import SwiftUI

public struct PBIconValue: View {
  let icon: FontAwesome
  let iconSize: PBIcon.IconSize
  let text: String?
  
  public init(
    icon: FontAwesome = .heart,
    iconSize: PBIcon.IconSize = .large,
    text: String? = nil
  ) {
    self.icon = icon
    self.iconSize = iconSize
    self.text = text
  }

    public var body: some View {
      iconValueView
    }
}

extension PBIconValue {
  var iconValueView: some View {
    HStack {
      PBIcon(icon, size: iconSize)
      if let text = text {
        Text(text)
      }
    }
    .pbFont(.body, variant: .bold, color: .text(.light))
  }
}
#Preview {
  registerFonts()
   return PBIconValue()
}
