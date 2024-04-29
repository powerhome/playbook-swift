//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  SectionSeparatorCatalog.swift
//

import SwiftUI

public struct SectionSeparatorCatalog: View {

  public init() {}

  public var body: some View {
    ScrollView {
      let loremIpsum: some View = Text(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididt labore et dolore"
      )
      .pbFont(.body)

      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Line separator") {
          PBSectionSeparator()
        }

        PBDoc(title: "Dashed separator") {
          PBSectionSeparator(variant: .dashed)
        }

        PBDoc(title: "Text separator") {
          PBSectionSeparator("Text separator")
        }

        PBDoc(title: "Children separator") {
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

        PBDoc(title: "Vertical separator") {
          HStack(spacing: Spacing.none) {
            loremIpsum
            PBSectionSeparator(orientation: .vertical)
            loremIpsum
          }
          .frame(maxWidth: .infinity)
          .frame(height: 120, alignment: .center)
          .listRowSeparator(.hidden)
        }
      }
      .padding(Spacing.medium)
    }
    .navigationTitle("Section Separator")
  }
}
