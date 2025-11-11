//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  SectionSeparatorCatalog.swift
//

import SwiftUI
import Playbook

public struct SectionSeparatorCatalog: View {
  let loremIpsum: some View = Text(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididt labore et dolore"
  )
    .pbFont(.body)
  public init() {}

  public var body: some View {
    PBDocStack(title: "Section Separator") {
      PBDoc(title: "Line separator") {
        lineSeparator
      }
      PBDoc(title: "Dashed separator") {
        dashedSeparator
      }
      PBDoc(title: "Text separator") {
        textSeparator
      }
      PBDoc(title: "Children separator") {
        childrenSeparator
      }
      PBDoc(title: "Vertical separator") {
        verticalSeparator
      }
      PBDoc(title: "Color separator") {
        colorSeparator
      }
    }
  }
}

extension SectionSeparatorCatalog {
  var lineSeparator: some View {
    PBSectionSeparator()
  }
  var dashedSeparator: some View {
    PBSectionSeparator(variant: .dashed)
  }
  var textSeparator: some View {
    PBSectionSeparator("Text separator")
  }
  var childrenSeparator: some View {
    PBSectionSeparator(variant: .dashed) {
      PBCard(alignment: .center, borderRadius: BorderRadius.rounded, padding: Spacing.xxSmall, width: 70) {
        Text("Today")
          .minimumScaleFactor(0.5)
          .lineLimit(1)
          .pbFont(.caption)
          .frame(maxWidth: .infinity, alignment: .center)
      }
    }
  }
  var verticalSeparator: some View {
    HStack(spacing: Spacing.none) {
      loremIpsum
      PBSectionSeparator(orientation: .vertical)
      loremIpsum
    }
    .frame(maxWidth: .infinity)
    .frame(height: 120, alignment: .center)
    .listRowSeparator(.hidden)
  }
  var colorSeparator: some View {
    VStack(spacing: Spacing.medium) {
      PBSectionSeparator(
        dividerColor: .status(.error)
      )
      PBSectionSeparator(
        variant: .dashed,
        dividerColor: .status(.success)
      )
      PBSectionSeparator(
        "Text separator",
        dividerColor: .status(.primary),
        textColor: .status(.primary)
      )
      PBSectionSeparator(variant: .dashed, dividerColor: .status(.warning)) {
        PBCard(alignment: .center, borderRadius: BorderRadius.rounded, padding: Spacing.xxSmall, width: 70) {
          Text("Today")
            .foregroundStyle(Color.status(.warning))
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            .pbFont(.caption)
            .frame(maxWidth: .infinity, alignment: .center)
        }
      }
    }
  }
}

#Preview {
  registerFonts()
  return SectionSeparatorCatalog()
}
