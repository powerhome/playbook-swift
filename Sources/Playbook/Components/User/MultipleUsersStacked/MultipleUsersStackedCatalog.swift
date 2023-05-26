//
//  MultipleUsersStackedCatalog.swift
//  
//
//  Created by Isis Silva on 26/05/23.
//

import SwiftUI

public struct MultipleUsersStackedCatalog: View {
  public var body: some View {
    List {
      Section("Small") {
        HStack(alignment: .top) {
          PBMultipleUsersStacked(users: oneUser)
          PBMultipleUsersStacked(users: twoUsers)
          PBMultipleUsersStacked(users: multipleUsers)
        }
      }

      Section("xSmall") {
        HStack(alignment: .top) {
          PBMultipleUsersStacked(users: oneUser, size: .xSmall)
          PBMultipleUsersStacked(users: twoUsers, size: .xSmall)
          PBMultipleUsersStacked(users: multipleUsers, size: .xSmall)
        }
      }

      Section("Default") {
        HStack(alignment: .top) {
          PBMultipleUsersStacked(users: oneUser, size: .default)
          PBMultipleUsersStacked(users: twoUsers, size: .default)
          PBMultipleUsersStacked(users: multipleUsers, size: .default)
        }
      }
    }
    .navigationTitle("Multiple User Stacked")
  }
}
