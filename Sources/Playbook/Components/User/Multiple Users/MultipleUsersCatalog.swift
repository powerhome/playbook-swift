//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  MultipleUsersCatalog.swift
//

import SwiftUI

public struct MultipleUsersCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "xSmall") {
          PBMultipleUsers(users: Mocks.twoUsers, size: .xSmall)
        }

        PBDoc(title: "Small") {
          PBMultipleUsers(users: Mocks.multipleUsers, size: .small)
        }

        PBDoc(title: "Small Reverse") {
          VStack(alignment: .leading, spacing: Spacing.small) {
            PBMultipleUsers(users: Mocks.multipleUsers, size: .small, reversed: true)
            PBMultipleUsers(users: Mocks.twoUsers, size: .small, reversed: true)
          }
        }
      }
      .padding(Spacing.medium)
    }
    .navigationTitle("Multiple Users")
  }
}
