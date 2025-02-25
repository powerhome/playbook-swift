//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBPerson.swift
//

import SwiftUI

public struct PBPerson: View {
  let firstName: String
  let lastName: String
  public init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
  public var body: some View {
    HStack(spacing: 2) {
      Text(firstName)
        .pbFont(.body)
      Text(lastName)
        .bold()
        .pbFont(.body)
    }
  }
}

#Preview {
  PBPerson(firstName: "John", lastName: "Doe")
}
