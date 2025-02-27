//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PersonContactCatalog.swift
//

import SwiftUI
import Playbook

public struct PersonContactCatalog: View {
    public var body: some View {
      PBDocStack(title: "Person Contact") {
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
    }
}

public extension PersonContactCatalog {
  var defaultView: some View {
    let contacts = [
      PBContact(type: .email, value: "email@example.com", detail: false),
      PBContact(type: .home, value: "(555) 555-5555", detail: false),
      PBContact(type: .work, value: "(324) 562-7482", detail: false)
    ]
  
    return PBPersonContact(firstName: "Pauline", lastName: "Smith", contacts: contacts)
   
  }
  var multiplePeopleView: some View {
    
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      PBPersonContact(firstName: "Harvey", lastName: "Walters", contacts: [PBContact(type: .email, value: "email@example.com", detail: false), PBContact(type: .home, value: "(555) 555-5555", detail: false), PBContact(type: .work, value: "(324) 562-7482", detail: false)])
      Spacer()
      PBPersonContact(firstName: "Brenda", lastName: "Walters", contacts: [PBContact(type: .home, value: "(555) 555-5555", detail: false)])
    }
  }
  var withDetailView: some View {
    let contacts = [
      PBContact(type: .email, value: "email@example.com", detail: false),
      PBContact(type: .home, value: "(555) 555-5555", detail: false),
      PBContact(type: .work, value: "(324) 562-7482", detail: false)
    ]
   
     return PBPersonContact(firstName: "Harvey", lastName: "Walters", contacts: contacts)
    
  }
  var withWrongNumbersView: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      PBPersonContact(firstName: "Pauline", lastName: "Smith", contacts: [PBContact(type: .email, value: "email@example.com", detail: false), PBContact(type: .home, value: " (555) 555-5555", detail: false), PBContact(type: .home, value: "(304) 861-5385", detail: false)])

      PBPersonContact(firstName: "", lastName: "", contacts: [PBContact(type: .custom("", .phoneSlash), value: "(324) 562-7482", detail: false)])
       
        
    }
   
  }
}

//#Preview {
//   return PersonContactCatalog()
//}
