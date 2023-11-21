//
//  Person.swift
//  
//
//  Created by Stephen Marshall on 11/21/23.
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
    HStack {
      Text(firstName)
        .pbFont(.body)
      Text(lastName)
        .bold()
        .pbFont(.body)
    }
  }
}

public struct PBPerson_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return PBPerson(firstName: "John", lastName: "Doe")
  }
}
