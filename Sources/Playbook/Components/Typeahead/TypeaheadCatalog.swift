//
//  TypeaheadCatalog.swift
//  
//
//  Created by Isis Silva on 23/08/23.
//

import SwiftUI

@available(iOS 16.0, *)
public struct TypeaheadCatalog: View {
  @State private var searchTextColors: String = ""
  @State private var assetsColors = Mocks.assetsColors
  @State private var searchTextUsers: String = ""
  @State private var assetsUsers = Mocks.multipleUsersDictionary

  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default", spacing: Spacing.small) {
          PBTypeahead(title: "Colors", searchText: $searchTextColors, selection: .single, options: assetsColors, variant: .text)
        }

        PBDoc(title: "With Pills", spacing: Spacing.small) {
          PBTypeahead(title: "Users", placeholder: "type the name of a user", searchText: $searchTextUsers, selection: .multiple, options: assetsUsers, variant: .pill)
        }
      }
      .padding(Spacing.medium)
    }
    .scrollDismissesKeyboard(.immediately)
    .background(Color.background(.light))
    .navigationTitle("Typeahead")
  }
}
