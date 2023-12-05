//
//  TypeaheadCatalog.swift
//  
//
//  Created by Isis Silva on 23/08/23.
//

import SwiftUI

public struct TypeaheadCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          PBTypeahead(title: "Colors", variant: .text)
        }
        
        PBDoc(title: "Name") {
          PBTypeahead(title: "Users", variant: .pill)
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(.light))
    .navigationTitle("Typeahead")
  }
}
