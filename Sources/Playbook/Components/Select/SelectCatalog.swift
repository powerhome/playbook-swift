//
//  SwiftUIView.swift
//
//
//  Created by Carlos Lima on 8/24/23.
//

import SwiftUI

public struct SelectCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          Group {
            Button("Burgers") {}
              .buttonStyle(PBSelect("FAVORITE FOOD", style: .default))
              .preferredColorScheme(.light)
          }
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Select")
  }
}
