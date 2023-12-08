//
//  TypeaheadCatalog.swift
//  
//
//  Created by Isis Silva on 23/08/23.
//

import SwiftUI

public struct TypeaheadCatalog: View {
  @State var assets = ["Apple" : nil, "Banana" : nil, "Cherry" : nil, "Grapes" : nil, "Orange" : nil]
  @State var users = Mocks.multipleUsers
  @State private var searchText: String = ""
  
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          PBTypeahead(title: "Colors", searchText: $searchText, options: assets, variant: .text)
        }
        
        PBDoc(title: "Users") {
          PBTypeahead(title: "Users", searchText: $searchText, options: Mocks.multipleUsersDictionary, variant: .pill)
        }
        
//        PBDoc(title: "Users") {
//          PBTypeahead(title: "Users", searchText: $searchText, options: users, variant: .pill)
//        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(.light))
    .navigationTitle("Typeahead")
  }
}
