//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  MultipleUsersIndicatorCatalog.swift
//

import SwiftUI

public struct MultipleUsersIndicatorCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Multiple Users Indicator") {
          VStack(alignment: .leading, spacing: Spacing.xSmall) {
            PBMultipleUsersIndicator(usersCount: 4, size: .xxSmall)
            PBMultipleUsersIndicator(usersCount: 4, size: .xSmall)
          }
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Multiple Users Indicator")
  }
}
