//
//  SectionSeparatorCatalog.swift
//
//
//  Created by Israel Molestina on 6/20/23.
//

import SwiftUI

public struct SectionSeparatorCatalog: View {

  public init() {}

  public var body: some View {

    List {
      Section("Line separator") {
        textView()
        lineView()
      }
      .listRowSeparator(.hidden)
      Section("Dashed separator") {
        dashedView()
        dashedTextView()
      }

      .listRowSeparator(.hidden)

      Section("Children separator") {
        childrenView()
      }

      Section("Vertical separator") {
        verticalView()
      }
    }
  }

  func textView() -> some View {
    PBSectionSeparator("Title separator")
  }

  func lineView() -> some View {
    PBSectionSeparator()
  }

  func dashedTextView() -> some View {
    PBSectionSeparator("Title separator", variant: .dashed)
  }

  func dashedView() -> some View {
    PBSectionSeparator(variant: .dashed)
  }

  func childrenView() -> some View {
    PBSectionSeparator(variant: .dashed) {
      PBCard(alignment: .center, borderRadius: BorderRadius.rounded, padding: Spacing.xxSmall, width: 70) {
        Text("Today")
          .pbFont(.caption)
          .frame(maxWidth: .infinity, alignment: .center)
      }
    }
  }

  func verticalView() -> some View {
    HStack(spacing: 0) {
      loremIpsum
      PBSectionSeparator(orientation: .vertical)
      loremIpsum
    }
    .frame(maxWidth: .infinity)
    .frame(height: 120, alignment: .center)
    .listRowSeparator(.hidden)
  }

  let loremIpsum: some View = Text(
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididt labore et dolore"
  )
  .pbFont(.body())
}
