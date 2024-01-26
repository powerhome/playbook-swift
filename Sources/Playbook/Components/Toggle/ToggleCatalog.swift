//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ToggleCatalog.swift
//

import SwiftUI

public struct ToggleCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          VStack(spacing: Spacing.small) {
            PBToggle(checked: true)
            PBToggle(checked: false)
          }
        }

        PBDoc(title: "Name") {
          VStack(spacing: Spacing.small) {
            PBToggle(label: "car", checked: false)
            PBToggle(label: "bike", checked: false)
          }
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Toggle")
  }
}

struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    ToggleCatalog()
  }
}
