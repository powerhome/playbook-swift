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
      PBPersonContact(firstName: "Pauline", lastName: "Smith", contacts: [PBContact(type: .email, value: "email@example.com", detail: false), PBContact(type: .home, value: "(555) 555-5555", detail: false), PBContact(type: .work, value: "(324) 562-7482", detail: false)])
    }
  }
  var multiplePeopleView: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      PBPersonContact(firstName: "Harvey", lastName: "Walters", contacts: [PBContact(type: .email, value: "email@example.com", detail: false), PBContact(type: .home, value: "(555) 555-5555", detail: false), PBContact(type: .work, value: "(324) 562-7482", detail: false)])
      Spacer()
      PBPersonContact(firstName: "Brenda", lastName: "Walters", contacts: [PBContact(type: .home, value: "(555) 555-5555", detail: false)])
    }
  }
  var withDetailView: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      PBPersonContact(firstName: "Harvey", lastName: "Walters", contacts: [PBContact(type: .email, value: "email@example.com", detail: false), PBContact(type: .home, value: "(555) 555-5555", detail: true), PBContact(type: .work, value: "(324) 562-7482", detail: true)])
    }
  }
  var withWrongNumbersView: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      PBPersonContact(firstName: "Pauline", lastName: "Smith", contacts: [PBContact(type: .email, value: "email@example.com", detail: false), PBContact(type: .home, value: " (555) 555-5555", detail: false), PBContact(type: .home, value: "(304) 861-5385", detail: false)])
     
      Text("wrong number")
        .pbFont(.caption)
      PBPersonContact(firstName: "", lastName: "", contacts: [PBContact(type: .custom("", .phoneSlash), value: "(324) 562-7482", detail: false)])
     
    }
  }
}

//#Preview {
//   return PersonContactCatalog()
//}