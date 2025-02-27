//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  RadioCatalog.swift
//

import SwiftUI
import Playbook

public struct RadioCatalog: View {
  @State private var selectedDefault: PBRadioItem? = PBRadioItem("Power")
  @State private var selectedCustom: PBRadioItem? = PBRadioItem("Custom Power")
  @State private var selectedError: PBRadioItem? = PBRadioItem("Power")
  @State private var selectedOrientation: PBRadioItem? = PBRadioItem("Power")
  @State private var selectedAlignment: PBRadioItem? = PBRadioItem("Power")
  @State private var selectedSpacing: PBRadioItem? = PBRadioItem("Small")
  @State private var selectedPadding: PBRadioItem? = PBRadioItem("Small")
  @State private var selectedSubtitle: PBRadioItem? = PBRadioItem("Power")
  var orientation: Orientation = .vertical

  public init(
    orientation: Orientation = .vertical
  ) {
    self.orientation = orientation
  }

  public var body: some View {
    PBDocStack(title: "Radio") {
      PBDoc(title: "Default") {
        defaultView()
      }

      PBDoc(title: "Custom") {
        customView()
      }

      PBDoc(title: "With Error") {
        errorView()
      }

      PBDoc(title: "Orientation") {
        orientationView()
      }

      PBDoc(title: "Text Alignment") {
        TextAlignmentView()
      }

      PBDoc(title: "Spacing") {
        spacingView()
      }

      PBDoc(title: "Padding") {
        paddingView()
      }

      PBDoc(title: "Subtitle") {
        subtitleView()
      }
    }
  }
}

extension RadioCatalog {
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
  func customView() -> some View {
    VStack(alignment: .leading) {
      if let selectedCustom = selectedCustom {
        Text("Your choice is: \(selectedCustom.title)")
          .pbFont(.detail(true), color: .text(.default))
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
  func errorView() -> some View {
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
  func orientationView() -> some View {
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
      .lineLimit(1)
      .minimumScaleFactor(0.5)
        
    }
  }
  func TextAlignmentView() -> some View {
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
  func spacingView() -> some View {
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
    .lineLimit(3)
    .minimumScaleFactor(1.0)
  }
  func paddingView() -> some View {
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
  func subtitleView() -> some View {
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
