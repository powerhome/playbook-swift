//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ContactCatalog.swift
//

import SwiftUI
import Playbook

public struct ContactCatalog: View {
  public var body: some View {
    PBDocStack(title: "Contact") {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Detail Indicator") {
        detailView
      }
    }
  }
}

public extension ContactCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBContact(type: .cell, value: "3491859988")
      PBContact(value: "5555555555")
      PBContact(type: .email, value: "email@example.com")
      PBContact(type: .work, value: "3245627482")
      PBContact(type: .workCell, value: "3245627482", detail: true)
    }
  }
  var detailView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBContact(type: .cell, value: "3491859988", detail: true)
      PBContact(value: "5555555555", detail: true)
      PBContact(type: .email, value: "email@example.com", detail: true)
      PBContact(type: .work, value: "3245627482", detail: true)
      PBContact(type: .ext, value: "1234", detail: true)
    }
  }
}

#Preview {
  registerFonts()
  return ContactCatalog()
}
