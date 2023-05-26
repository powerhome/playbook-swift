//
//  RadioCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct RadioCatalog: View {
  @State var selected: PBRadioItem? = PBRadioItem("Power")
  var orientation: Orientation = .vertical

  public init(
    selected: PBRadioItem? = nil,
    orientation: Orientation = .vertical
  ) {
    self.selected = selected
    self.orientation = orientation
  }

  public var body: some View {
    List {
      Section("Default") {
        defaultView()
      }
      Section("Custom") {
        customView()
      }
      Section("With Error") {
        errorView()
      }
      Section("Orientation") {
        orientationView()
      }
      Section("Text Alignment") {
        TextAlignmentView()
      }
      Section("Spacing") {
        spacingView()
      }
      Section("Padding") {
        paddingView()
      }
      Section("Subtitle") {
        subtitleView()
      }
    }
  }

  func defaultView() -> some View {
    VStack(alignment: .leading) {
      PBRadio(
        items: [
          PBRadioItem("Power"),
          .init("Nitro"),
          .init("Google")
        ],
        orientation: .vertical,
        selected: $selected
      )
    }
  }

  func	customView() -> some View {
    VStack(alignment: .leading) {
      if let selected = selected {
        Text("Your choice is: \(selected.title)")
      }
      PBRadio(
        items: [
          PBRadioItem("Custom Power"),
          .init("Custom Nitro"),
          .init("Custom Google")
        ],
        orientation: .vertical,
        selected: $selected
      )
    }
  }

  func	errorView() -> some View {
    VStack(alignment: .leading) {
      PBRadio(
        items: [
          PBRadioItem("Power")
        ],
        orientation: .vertical,
        selected: $selected,
        errorState: true
      )
    }
  }

  func	orientationView() -> some View {
    VStack(alignment: .leading) {
      PBRadio(
        items: [
          PBRadioItem("Power"),
          .init("Nitro"),
          .init("Google")
        ],
        orientation: .horizontal,
        selected: $selected
      )
    }
  }

  func	TextAlignmentView() -> some View {
    VStack(alignment: .leading) {
      PBRadio(
        items: [
          PBRadioItem("Power"),
          .init("Nitro"),
          .init("Google")
        ],
        orientation: .horizontal,
        textAlignment: .vertical,
        selected: $selected
      )
    }
  }

  func	spacingView() -> some View {
    HStack(alignment: .top) {
      PBRadio(
        items: [
          PBRadioItem("Small"),
          .init("Spacing"),
          .init("Power")
        ],
        orientation: .vertical,
        spacing: Spacing.small,
        selected: $selected
      )
      PBRadio(
        items: [
          PBRadioItem("Medium"),
          .init("Spacing"),
          .init("Power")
        ],
        orientation: .vertical,
        spacing: Spacing.medium,
        selected: $selected
      )
      PBRadio(
        items: [
          PBRadioItem("Large"),
          .init("Spacing"),
          .init("Power")
        ],
        orientation: .vertical,
        spacing: Spacing.large,
        selected: $selected
      )
    }
  }

  func	paddingView() -> some View {
    VStack(alignment: .leading) {
      PBRadio(
        items: [
          PBRadioItem("Small")
        ],
        orientation: .vertical,
        padding: Spacing.small,
        selected: $selected
      )
      PBRadio(
        items: [
          PBRadioItem("Medium")
        ],
        orientation: .vertical,
        padding: Spacing.medium,
        selected: $selected
      )
      PBRadio(
        items: [
          PBRadioItem("Large")
        ],
        orientation: .vertical,
        padding: Spacing.large,
        selected: $selected
      )
    }
  }

  func	subtitleView() -> some View {
    VStack(alignment: .leading) {
      PBRadio(
        items: [
          PBRadioItem("Power", subtitle: "subtitle")
        ],
        selected: $selected
      )
    }
  }
}
