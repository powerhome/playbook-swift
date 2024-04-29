//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PersonCatalog.swift
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
