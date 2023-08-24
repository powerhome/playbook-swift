//
//  MultipleUsersStackedCatalog.swift
//
//
//  Created by Isis Silva on 26/05/23.
//

import SwiftUI

public struct MultipleUsersStackedCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Small") {
          HStack(spacing: Spacing.xSmall) {
            PBMultipleUsersStacked(users: oneUser)
            PBMultipleUsersStacked(users: twoUsers)
            PBMultipleUsersStacked(users: multipleUsers)
          }
        }

        PBDoc(title: "xSmall") {
          HStack(spacing: Spacing.xSmall) {
            PBMultipleUsersStacked(users: oneUser, size: .xSmall)
            PBMultipleUsersStacked(users: twoUsers, size: .xSmall)
            PBMultipleUsersStacked(users: multipleUsers, size: .xSmall)
          }
        }

        PBDoc(title: "Default") {
          HStack(spacing: Spacing.xSmall) {
            PBMultipleUsersStacked(users: oneUser, size: .default)
            PBMultipleUsersStacked(users: twoUsers, size: .default)
            PBMultipleUsersStacked(users: multipleUsers, size: .default)
          }
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Multiple Users Stacked")
  }
}
