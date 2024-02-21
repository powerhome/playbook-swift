//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  TypeaheadCatalog.swift
//

import SwiftUI

public struct TypeaheadCatalog: View {
  @State private var searchTextColors: String = ""
  @State private var assetsColors = Mocks.assetsColors
  @State private var searchTextUsers: String = ""
  @State private var assetsUsers = Mocks.multipleUsersDictionary

  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default", spacing: Spacing.small) {
          PBTypeahead(
            title: "Colors",
            searchText: $searchTextColors,
            selection: .single,
            options: assetsColors
          )
        }

        PBDoc(title: "With Pills", spacing: Spacing.small) {
          PBTypeahead(
            title: "Users",
            placeholder: "type the name of a user",
            searchText: $searchTextUsers,
            selection: .multiple(variant: .pill),
            options: assetsUsers
          )
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(.light))
    .navigationTitle("Typeahead")
    .scrollDismissesKeyboard(.immediately)
  }
}
