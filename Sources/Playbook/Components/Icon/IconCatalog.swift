//
//  IconCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct IconCatalog: View {
  public var body: some View {
    List {
      Section("Default") {
        PBIcon.fontAwesome(.user, size: .x1)
      }

      Section("Rotate") {
        HStack {
          PBIcon(FontAwesome.user, rotation: .right)
          PBIcon(FontAwesome.user, rotation: .zero)
          PBIcon(FontAwesome.user, rotation: .obtuse)
        }
      }

      Section("Flipped") {
        HStack {
          PBIcon(FontAwesome.questionCircle, flipped: [.horizontal])
          PBIcon(FontAwesome.questionCircle, flipped: [.vertical])
          PBIcon(FontAwesome.questionCircle, flipped: [.horizontal, .vertical])
        }
      }

      Section("Border") {
        HStack {
          PBIcon(FontAwesome.user, border: true)
        }
      }

      Section("Size") {
        ForEach(PBIcon.IconSize.allCases, id: \.fontSize) { size in
          HStack {
            PBIcon.fontAwesome(.atlas, size: size)
            Text(size.rawValue)
          }
        }
        .listRowSeparator(.hidden)
      }
    }
    .navigationTitle("Icon")
  }
}
