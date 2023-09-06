//
//  SwiftUIView.swift
//
//
//  Created by Carlos Lima on 24/08/23.
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
