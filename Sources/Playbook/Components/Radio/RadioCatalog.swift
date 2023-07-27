//
//  RadioCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct RadioCatalog: View {
  @State var selectedDefault: PBRadioItem? = PBRadioItem("Power")
  @State var selectedCustom: PBRadioItem? = PBRadioItem("Custom Power")
  @State var selectedError: PBRadioItem? = PBRadioItem("Power")
  @State var selectedOrientation: PBRadioItem? = PBRadioItem("Power")
  @State var selectedAlignment: PBRadioItem? = PBRadioItem("Power")
  @State var selectedSpacing: PBRadioItem? = PBRadioItem("Small")
  @State var selectedPadding: PBRadioItem? = PBRadioItem("Small")
  @State var selectedSubtitle: PBRadioItem? = PBRadioItem("Power")
  var orientation: Orientation = .vertical

  public init(
    selectedDefault: PBRadioItem? = nil,
    selectedCustom: PBRadioItem? = nil,
    selectedError: PBRadioItem? = nil,
    selectedOrientation: PBRadioItem? = nil,
    selectedAlignment: PBRadioItem? = nil,
    selectedSpacing: PBRadioItem? = nil,
    selectedPadding: PBRadioItem? = nil,
    selectedSubtitle: PBRadioItem? = nil,
    orientation: Orientation = .vertical
  ) {
    self.selectedDefault = selectedDefault
    self.selectedCustom = selectedCustom
    self.selectedError = selectedError
    self.selectedOrientation = selectedOrientation
    self.selectedAlignment = selectedAlignment
    self.selectedSpacing = selectedSpacing
    self.selectedPadding = selectedPadding
    self.selectedSubtitle = selectedSubtitle
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
        selected: $selectedDefault
      )
    }
  }

  func	customView() -> some View {
    VStack(alignment: .leading) {
      if let selectedCustom = selectedCustom {
        Text("Your choice is: \(selectedCustom.title)")
      }
      PBRadio(
        items: [
          PBRadioItem("Custom Power"),
          .init("Custom Nitro"),
          .init("Custom Google")
        ],
        orientation: .vertical,
        selected: $selectedCustom
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
        selected: $selectedError,
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
        selected: $selectedOrientation
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
        selected: $selectedAlignment
      )
    }
  }

  func	spacingView() -> some View {
    HStack(alignment: .top) {
      PBRadio(
        items: [
          PBRadioItem("Small"),
          .init("Small Spacing"),
          .init("Small Power")
        ],
        orientation: .vertical,
        spacing: Spacing.small,
        selected: $selectedSpacing
      )
      PBRadio(
        items: [
          PBRadioItem("Medium"),
          .init("Medium Spacing"),
          .init("Medium Power")
        ],
        orientation: .vertical,
        spacing: Spacing.medium,
        selected: $selectedSpacing
      )
      PBRadio(
        items: [
          PBRadioItem("Large"),
          .init("Large Spacing"),
          .init("Large Power")
        ],
        orientation: .vertical,
        spacing: Spacing.large,
        selected: $selectedSpacing
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
        selected: $selectedPadding
      )
      PBRadio(
        items: [
          PBRadioItem("Medium")
        ],
        orientation: .vertical,
        padding: Spacing.medium,
        selected: $selectedPadding
      )
      PBRadio(
        items: [
          PBRadioItem("Large")
        ],
        orientation: .vertical,
        padding: Spacing.large,
        selected: $selectedPadding
      )
    }
  }

  func	subtitleView() -> some View {
    VStack(alignment: .leading) {
      PBRadio(
        items: [
          PBRadioItem("Power", subtitle: "subtitle")
        ],
        selected: $selectedSubtitle
      )
    }
  }
}
