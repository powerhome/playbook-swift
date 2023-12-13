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
  let contactType: PBContact.ContactType?
  let contactValue: String?
  let contactDetail: Bool?
  let variant: Variant?
  public init(
    firstName: String? = nil,
    lastName: String? = nil,
    contactType: PBContact.ContactType? = nil,
    contactValue: String? = nil,
    contactDetail: Bool? = nil,
    variant: Variant? = nil
  ) {
    self.firstName = firstName
    self.lastName = lastName
    self.contactType = contactType
    self.contactValue = contactValue
    self.contactDetail = contactDetail
    self.variant = variant
  }

  public var body: some View {
    VStack(spacing: Spacing.medium) {
      if variant == .person {
        nameView
      } else if variant == .contact {
        contactView
      }
    }
  }
}

public extension PBPersonContact {
  enum Variant {
    case person, contact
    
  }
  var nameView: some View {
    return PBPerson(firstName: firstName ?? "Pauline", lastName: lastName ?? "Smith")
  }
  var contactView: some View {
    return PBContact(type: contactType ?? PBContact.ContactType.email, value: contactValue ?? "email@example.com", detail: contactDetail ?? false)
  }
}

#Preview {
  registerFonts()
  return PersonContactCatalog()
}
