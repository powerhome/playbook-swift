//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  MultipleUsersStackedCatalog.swift
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
    .navigationTitle("Multiple Users Stacked")
  }
}
