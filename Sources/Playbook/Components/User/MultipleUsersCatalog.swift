//
//  MultipleUsersCatalog.swift
//
//
//  Created by Carlos Lima on 24/08/23.
//

import SwiftUI

public struct MultipleUsersCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "xSmall") {
          PBMultipleUsers(users: twoUsers, size: .xSmall)
        }

        PBDoc(title: "Small") {
          PBMultipleUsers(users: multipleUsers, size: .small)
        }

        PBDoc(title: "Small Reverse") {
          VStack(alignment: .leading, spacing: Spacing.small) {
            PBMultipleUsers(users: multipleUsers, size: .small, reversed: true)
            PBMultipleUsers(users: twoUsers, size: .small, reversed: true)
          }
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Multiple Users")
  }
}
