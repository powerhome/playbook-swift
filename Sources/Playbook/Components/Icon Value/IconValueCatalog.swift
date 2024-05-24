//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  IconValueCatalog.swift
//

import SwiftUI

public struct IconValueCatalog: View {
    public var body: some View {
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Default") {
            defaultView
          }

          PBDoc(title: "Alignment") {
            alignmentView
          }
        }
        .padding(Spacing.medium)
      }
      .background(Color.background(.default))
      .navigationTitle("Icon Value")
      
    }
}

extension IconValueCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBIconValue(icon: .heart, iconSize: .large, text: "93")
      PBIconValue(icon: .comment, iconSize: .large, text: "5")
      PBIconValue(icon: .clock, iconSize: .large, text: "15m")
    }
  }
  var alignmentView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      HStack {
        PBIconValue(icon: .heart, iconSize: .large, text: "93")
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      HStack {
        PBIconValue(icon: .comment, iconSize: .large, text: "5")
      }
      .frame(maxWidth: .infinity, alignment: .center)
      HStack {
        PBIconValue(icon: .clock, iconSize: .large, text: "15m")
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
}
#Preview {
  registerFonts()
   return IconValueCatalog()
}
