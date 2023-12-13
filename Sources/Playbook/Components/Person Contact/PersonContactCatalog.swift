//
//  PersonContactCatalog.swift
//  
//
//  Created by Rachel Radford on 12/13/23.
//

import SwiftUI

public struct PersonContactCatalog: View {
    public var body: some View {
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Default") {
            defaultView
          }
          PBDoc(title: "Multiple People") {
            multiplePeopleView
          }
          PBDoc(title: "With Detail") {
            withDetailView
          }
          PBDoc(title: "With Wrong Numbers") {
            withWrongNumbersView
          }
        }
        .padding(Spacing.medium)
      }
      .background(Color.background(.light))
      .navigationTitle("Person Contact")

    }
}

public extension PersonContactCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      PBPersonContact(firstName: "Pauline", lastName: "Smith", variant: .person)
      PBPersonContact(contactType: .email , contactValue: "email@example.com", contactDetail: false, variant: .contact)
      PBPersonContact(contactType: .home , contactValue: "(555) 555-5555", contactDetail: false, variant: .contact)
      PBPersonContact(contactType: .work , contactValue: "(342) 562-7482", contactDetail: false, variant: .contact)
    }
  }
  var multiplePeopleView: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      PBPersonContact(firstName: "Harvey", lastName: "Walters", variant: .person)
      PBPersonContact(contactType: .email, contactValue: "email@example.com", variant: .contact)
      PBPersonContact(contactType: .home, contactValue: "(555) 555-5555", variant: .contact)
      PBPersonContact(contactType: .work, contactValue: "(324) 562-7482", variant: .contact)
      Spacer()
      PBPersonContact(firstName: "Brenda", lastName: "Walters", variant: .person)
      PBPersonContact(contactType: .home, contactValue: "(555) 555-5555", variant: .contact)
    }
  }
  var withDetailView: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      PBPersonContact(firstName: "Harvey", lastName: "Walters", variant: .person)
      PBPersonContact(contactType: .email, contactValue: "email@example.com", variant: .contact)
      PBPersonContact(contactType: .home, contactValue: "(555) 555-5555", contactDetail: true, variant: .contact)
      PBPersonContact(contactType: .work, contactValue: "(324) 562-7482", contactDetail: true, variant: .contact)
    }
  }
  var withWrongNumbersView: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      PBPersonContact(firstName: "Pauline", lastName: "Smith", variant: .person)
      PBPersonContact(contactType: .email, contactValue: "email@example.com", variant: .contact)
      PBPersonContact(contactType: .home, contactValue: "(555) 555-5555", variant: .contact)
      PBPersonContact(contactType: .home, contactValue: "(304) 861-5385", variant: .contact)
      Spacer()
      Text("Wrong Number")
        .pbFont(.caption, variant: .bold, color: .text(.light))
      PBPersonContact(contactType: .custom("", FontAwesome.phoneSlash), contactValue: "(324) 562-7482", variant: .contact)
    }
  }
}

//#Preview {
//   return PersonContactCatalog()
//}
