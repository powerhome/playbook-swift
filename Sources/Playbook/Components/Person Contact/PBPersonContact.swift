//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBPersonContact.swift
//

import SwiftUI

public struct PBPersonContact: View {
  let firstName: String?
  let lastName: String?
  let contacts: [PBContact]
  
  public init(
    firstName: String? = nil,
    lastName: String? = nil,
    contacts: [PBContact]
  ) {
    self.firstName = firstName
    self.lastName = lastName
    self.contacts = contacts
  }

  public var body: some View {
    personOrContactView
  }
}

public extension PBPersonContact {
  @ViewBuilder
  var personOrContactView: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      nameView
      contactView
    }
  }
  var nameView: some View {
    return PBPerson(firstName: firstName ?? "", lastName: lastName ?? "")
  }
  var contactView: some View {
    return ForEach(contacts, id: \.parsedValue) { contact in
      PBContact(type: contact.type, value: contact.contactValue, detail: contact.detail)
    }
  }
}

#Preview {
  registerFonts()
  return PersonContactCatalog()
}
