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
      Section("Alignment") {
        alignmentView()
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

  func	alignmentView() -> some View {
    VStack(alignment: .leading) {
      PBRadio(
        items: [
          PBRadioItem("Power"),
          .init("Nitro"),
          .init("Google")
        ],
        orientation: .horizontal,
        alignment: .vertical,
        selected: $selected
      )
    }
  }

  func	spacingView() -> some View {
    VStack(alignment: .leading) {
      PBRadio(
        items: [
          PBRadioItem("Power"),
          .init("Nitro"),
          .init("Google")
        ],
        orientation: .vertical,
        spacing: Spacing.medium,
        selected: $selected
      )
    }
  }

  func	paddingView() -> some View {
    VStack(alignment: .leading) {
      PBRadio(
        items: [
          PBRadioItem("Power"),
          .init("Nitro"),
          .init("Google")
        ],
        orientation: .vertical,
        padding: Spacing.medium,
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
