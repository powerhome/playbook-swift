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
      Section("Text separator") {
        textView()
      }

      Section("Line separator") {
        lineView()
      }

      Section("Background separator") {
        backGroundView()
      }

      Section("Bubble separator") {
        bubbleView()
      }

      Section("Content separator") {
        contentView()
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
      .padding(.top, 6)
  }

  func backGroundView() -> some View {
    PBSectionSeparator("Title separator", variant: .background)
  }
  func bubbleView() -> some View {
    PBSectionSeparator("Title separator", variant: .bubble)
  }

  func contentView() -> some View {
    PBSectionSeparator(variant: .background) {
      Text("Title separator").pbFont(.subcaption)
    }
  }

  func verticalView() -> some View {
    HStack {
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
  .padding()
}
