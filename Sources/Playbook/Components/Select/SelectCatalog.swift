//
//  SwiftUIView.swift
//
//
//  Created by Carlos Lima on 8/24/23.
//

import SwiftUI

public struct SelectCatalog: View {
  let defaultOptions = [
    (value: "1", text: "Burgers"),
    (value: "2", text: "Pizza"),
    (value: "3", text: "Tacos")
  ]

  let blankOptions = [
    (value: "0", text: "Select One..."),
    (value: "1", text: "Burgers"),
    (value: "2", text: "Pizza"),
    (value: "3", text: "Tacos")
  ]

  let equalOptions: [(value: String, text: String?)] = [
    (value: "Football", text: nil),
    (value: "Baseball", text: nil),
    (value: "Basketball", text: nil),
    (value: "Hockey", text: nil)
  ]

  @State private var defaultState = ""
  @State private var blankState = ""
  @State private var disabledState = ""
  @State private var equalState = ""
  @State private var errorState = ""

  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          PBSelect(title: "Favorite Food", options: defaultOptions, style: .default) { selected in
            defaultState = selected
          }
        }

        PBDoc(title: "Blank selection text") {
          PBSelect(title: "Favorite Food", options: blankOptions, style: .default) { selected in
            blankState = selected
          }
        }

        PBDoc(title: "Disabled select field") {
          PBSelect(title: "Favorite Food", options: defaultOptions, style: .disabled) { selected in
            disabledState = selected
          }
        }

        PBDoc(title: "Equal option value and value text") {
          PBSelect(title: "Favorite Sport", options: equalOptions, style: .default) { selected in
            equalState = selected
          }
        }

        PBDoc(title: "Select with error") {
          PBSelect(
            title: "Favorite Food",
            options: defaultOptions,
            style: .error("Please make a valid selection")
          ) { selected in
            errorState = selected
          }
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Select")
  }
}
