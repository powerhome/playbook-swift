//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PersonCatalog.swift
//

import SwiftUI
import Playbook

public struct PersonCatalog: View {
  public var body: some View {
    PBDocStack(title: "Person") {
      PBDoc(title: "Default") {
        defaultView
      }
    }
  }
}

public extension PersonCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBPerson(firstName: "Timothy", lastName: "Wenhold")
    }
  }
}
