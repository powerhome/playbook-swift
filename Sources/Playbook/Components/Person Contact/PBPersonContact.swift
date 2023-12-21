//
//  PBPersonContact.swift
//  
//
//  Created by Rachel Radford on 12/13/23.
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
    return PBPerson(firstName: firstName ?? "Pauline", lastName: lastName ?? "Smith")
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
