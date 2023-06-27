//
//  IconCircleCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

@available(macOS 13.0, *)
public struct IconCircleCatalog: View {
  public var body: some View {
    List {
      Section("Default") {
        PBIconCircle(FontAwesome.rocket)
      }

      Section("Size") {
        let pBIconSizes = [PBIcon.IconSize.small, PBIcon.IconSize.medium, PBIcon.IconSize.large]

        ForEach(pBIconSizes, id: \.self) { size in
          PBIconCircle(FontAwesome.rocket, size: size)
        }
      }
      .listRowSeparator(.hidden)

      Section("Color") {
        ForEach(Color.DataColor.allCases, id: \.self) { color in
          PBIconCircle(FontAwesome.rocket, size: .small, color: Color.data(color))
        }
      }
      .listRowSeparator(.hidden)
    }
    .navigationTitle("Icon Circle")
  }
}
