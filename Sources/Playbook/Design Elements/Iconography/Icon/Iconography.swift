//
//  Iconography.swift
//  
//
//  Created by Isis Silva on 28/06/23.
//

import SwiftUI

public struct Iconography: View {
  let columns = Array(repeating: GridItem(.adaptive(minimum: 65)), count: 3)
  public var body: some View {
    VStack {
      ScrollView {
        Text("FontAwesome Icons")
          .pbFont(.caption)
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
  }
}

struct Iconography_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return Iconography()
  }
}
