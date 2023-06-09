//
//  IconCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct IconCatalog: View {
  let columns = Array(repeating: GridItem(.adaptive(minimum: 100)), count: 3)
  public var body: some View {
    List {
      ForEach(PBIcon.IconSize.allCases, id: \.fontSize) { size in
        Section(size.rawValue) {
          PBIcon.fontAwesome(.user, size: size)
        }
      }

      LazyVGrid(columns: columns) {
        ForEach(FontAwesome.allCases, id: \.self) { icon in
          VStack {
            PBIcon.fontAwesome(icon, size: .medium)
            Text(icon.rawValue).pbFont(.subcaption)
          }
        }
      }
    }
    .navigationTitle("Iconography")
  }
}
