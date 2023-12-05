//
//  TypeaheadCatalog.swift
//  
//
//  Created by Isis Silva on 23/08/23.
//

import SwiftUI

public struct TypeaheadCatalog: View {
  @State var assets = ["Apple", "Banana", "Cherry", "Grapes", "Orange"]
  @State private var searchText: String = ""
  
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          PBTypeahead(title: "Colors", searchText: $searchText, options: assets, variant: .text)
        }
        
        PBDoc(title: "Name") {
          PBTypeahead(title: "Users", searchText: $searchText, options: assets, variant: .pill)
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(.light))
    .navigationTitle("Typeahead")
  }
}
