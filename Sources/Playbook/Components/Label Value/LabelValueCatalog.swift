//
//  LabelValueCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct LabelValueCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          VStack(alignment: .leading, spacing: Spacing.small) {
            PBLabelValue("Role", "Administrator, Moderator")
            PBLabelValue("Email", "anna.black@powerhrg.com")
            PBLabelValue("Bio", "Proin pulvinar feugiat massa in luctus. Donec urna nulla, elementum sit amet tincidunt")
          }
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Label Value")
  }
}
