//
//  TypeaheadCatalog.swift
//  
//
//  Created by Isis Silva on 23/08/23.
//

import SwiftUI

public struct TypeaheadCatalog: View {
  @State private var searchTextColors: String = ""
  @State private var assetsColors: [(String, AnyView?)] = [
    ("Orange", nil),
    ("Red", nil),
    ("Green", nil), 
    ("Blue", nil),
    ("Pink", nil)
  ]

  @State private var searchTextUsers: String = ""
  @State private var assetsUsers = Mocks.multipleUsersDictionary
  @State private var searchText: String = ""
  @State private var assets: [(String, AnyView?)] = [("Apple", nil), ("Banana", nil), ("Cherry", nil), ("Grapes", nil), ("Orange", nil)]

  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          PBTypeahead(title: "Colors", searchText: $searchTextColors, selection: .single, options: assetsColors, variant: .text)
        }

        PBDoc(title: "With Pills") {
          PBTypeahead(title: "Users", searchText: $searchText, selection: .multiple, options: assetsUsers, variant: .pill)
        }
      }
      .padding(Spacing.medium)
    }
    .scrollDismissesKeyboard(.immediately)
    .background(Color.background(.light))
    .navigationTitle("Typeahead")
  }
}
