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
            PBMultipleUsersStacked(users: Mocks.oneUser)
            PBMultipleUsersStacked(users: Mocks.twoUsers)
            PBMultipleUsersStacked(users: Mocks.multipleUsers)
          }
        }

        PBDoc(title: "xSmall") {
          HStack(spacing: Spacing.xSmall) {
            PBMultipleUsersStacked(users: Mocks.oneUser, size: .xSmall)
            PBMultipleUsersStacked(users: Mocks.twoUsers, size: .xSmall)
            PBMultipleUsersStacked(users: Mocks.multipleUsers, size: .xSmall)
          }
        }

        PBDoc(title: "Default") {
          HStack(spacing: Spacing.xSmall) {
            PBMultipleUsersStacked(users: Mocks.oneUser, size: .default)
            PBMultipleUsersStacked(users: Mocks.twoUsers, size: .default)
            PBMultipleUsersStacked(users: Mocks.multipleUsers, size: .default)
          }
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Multiple Users Stacked")
  }
}
