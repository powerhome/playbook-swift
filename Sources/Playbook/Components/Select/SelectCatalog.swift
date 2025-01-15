//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  SelectCatalog.swift
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
    PBDocStack(title: "Select") {
      PBDoc(title: "Default") {
        defaultView
      }

      PBDoc(title: "Blank selection text") {
        blankSelectionText
      }

      PBDoc(title: "Disabled select field") {
        disabledSelectField
      }

      PBDoc(title: "Equal option value and value text") {
        equalValueView
      }

      PBDoc(title: "Select with error") {
        selectErrorView
      }
    }
  }
}

extension SelectCatalog {
  var defaultView: some View {
    PBSelect(
      title: "Favorite Food",
      options: defaultOptions,
      style: .default,
      selected: $defaultState
    ) { selected in
      defaultState = selected
    }
  }

  var blankSelectionText: some View {
    PBSelect(
      title: "Favorite Food",
      options: blankOptions,
      style: .default,
      selected: $blankState
    ) { selected in
      blankState = selected
    }
  }

  var disabledSelectField: some View {
    PBSelect(
      title: "Favorite Food", 
      options: defaultOptions, 
      style: .disabled, 
      selected: $disabledState
    ) { selected in
      disabledState = selected
    }
  }

  var equalValueView: some View {
    PBSelect(
      title: "Favorite Sport",
      options: equalOptions,
      style: .default,
      selected: $equalState
    ) { selected in
      equalState = selected
    }
  }

  var selectErrorView: some View {
    PBSelect(
      title: "Favorite Food",
      options: defaultOptions,
      style: .error("Please make a valid selection"),
      selected: $errorState
    ) { selected in
      errorState = selected
    }
  }
}
