//
//  SectionSeparatorCatalog.swift
//
//
//  Created by Israel Molestina on 6/20/23.
//

import SwiftUI

public struct SectionSeparatorCatalog: View {
  public var body: some View {

    let loremIpsum = Text(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididt labore et dolore"
    )
    .pbFont(.body())
    .padding()

    List {
      Section("Horizontal separators") {
        Text("Line separator").pbFont(.caption).padding()
        PBSectionSeparator()

        Text("Text separator").pbFont(.caption).padding()
        PBSectionSeparator("Title separator")

        Text("Background variant").pbFont(.caption).padding()
        PBSectionSeparator("Title separator", variant: .background)

        Text("Bubble variant").pbFont(.caption).padding()
        PBSectionSeparator("Title separator", variant: .bubble)

        Text("Content variant").pbFont(.caption).padding()
        PBSectionSeparator(variant: .background) {
          Text("Title separator").pbFont(.subcaption).padding(4)
        }
      }
      .listRowSeparator(.hidden)

      Section("Vertical separator") {
        HStack {
          loremIpsum
          PBSectionSeparator(orientation: .vertical)
          loremIpsum
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120, alignment: .center)
        .listRowSeparator(.hidden)
      }
    }
  }
}
