//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Iconography.swift
//

import SwiftUI
import Playbook

public struct Iconography: View {
  let columns = Array(repeating: GridItem(.adaptive(minimum: 65)), count: 3)
  public var body: some View {
    VStack {
      ScrollView {
        Text("FontAwesome Icons")
//          .pbFont(.caption)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding()

          LazyVGrid(columns: columns) {
            ForEach(FontAwesome.allCases, id: \.unicodeString) { icon in
              VStack {
                PBIcon.fontAwesome(icon, size: .x1)
                  .padding(2)
                Text(icon.rawValue).pbFont(.subcaption)
              }

            }
          }
      }
      .padding()
      .navigationTitle("Iconography")
    }
    .background(Color.background(.default))
  }
}

struct Iconography_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return Iconography()
  }
}
