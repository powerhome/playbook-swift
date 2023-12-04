//
//  TypeaheadCatalog.swift
//  
//
//  Created by Isis Silva on 23/08/23.
//

import SwiftUI

public struct TypeaheadCatalog: View {
  @State var popoverValue: AnyView?
  public var body: some View {

    ScrollView {
      VStack(spacing: 60) {
        PBTypeahead(title: "Colors", variant: .text)
        PBTypeahead(title: "Users", variant: .pill)
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Typeahead")

  }
}
