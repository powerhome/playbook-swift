//
//  Person.swift
//
//
//  Created by Stephen Marshall on 11/21/23.
//

import SwiftUI

public struct PersonCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          defaultView
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(.light))
    .navigationTitle("Person")
  }
}

public extension PersonCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBPerson(firstName: "Timothy", lastName: "Wenhold")
    }
  }
}
