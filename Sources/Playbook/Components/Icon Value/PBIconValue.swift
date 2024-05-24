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
  let text: String?
  
  public init(
    icon: FontAwesome = .heart,
    text: String? = nil
  ) {
    self.icon = icon
    self.text = text
  }

    public var body: some View {
      iconValueView
    }
}

extension PBIconValue {
  var iconValueView: some View {
    HStack {
      PBIcon(icon)
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
