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

  private var categories: [IconCategory] {
    let groupedIcons: [String: [Icons]] = Dictionary(
      grouping: Icons.allCases,
      by: \.categoryName
    )
    let categories = groupedIcons.map { category, icons in
      IconCategory(
        name: category,
        icons: icons.sorted { $0.rawValue < $1.rawValue }
      )
    }
    return categories.sorted { $0.name < $1.name }
  }

  public var body: some View {
    VStack {
      ScrollView {
        Text("Playbook Icons")
//          .pbFont(.caption)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding()

        LazyVStack(alignment: .leading, spacing: 24) {
          ForEach(categories) { category in
            VStack(alignment: .leading, spacing: 12) {
              Text(category.displayName)
                .pbFont(.caption)

              LazyVGrid(columns: columns) {
                ForEach(category.icons, id: \.rawValue) { icon in
                  VStack {
                    PBIcon.playbook(icon, size: .x1)
                      .padding(2)
                    Text(icon.displayName)
                      .pbFont(.subcaption)
                  }
                }
              }
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

private struct IconCategory: Identifiable {
  let name: String
  let icons: [Icons]

  var id: String { name }

  var displayName: String {
    name.replacingOccurrences(of: "-", with: " ").capitalized
  }
}

private extension Icons {
  var categoryName: String {
    rawValue.split(separator: "/", maxSplits: 1).first.map(String.init) ?? ""
  }

  var displayName: String {
    rawValue.split(separator: "/").last.map(String.init) ?? rawValue
  }
}

struct Iconography_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return Iconography()
  }
}
