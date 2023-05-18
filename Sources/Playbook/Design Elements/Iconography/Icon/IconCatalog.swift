//
//  IconCatalog.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct IconCatalog: View {
  public init() {}
  public var body: some View {
    List {
      ForEach(PBIcon.IconSize.allCases, id: \.fontSize) { size in
        Section(size.rawValue) {
          PBIcon.fontAwesome(.user, size: size)
        }
      }

      ForEach(FontAwesome.allCases, id: \.self) { icon in
        Section(icon.rawValue) {
          PBIcon.fontAwesome(icon, size: .small)
        }
      }
    }
    .navigationTitle("Iconography")
  }
}
