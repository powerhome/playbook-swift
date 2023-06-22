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

      Section("Background separator") {
        backGroundView()
      }

      Section("Bubble separator") {
        bubbleTextView()
        bubbleView()
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

  func backGroundView() -> some View {
    PBSectionSeparator("Title separator", variant: .background)
  }

  func bubbleTextView() -> some View {
    PBSectionSeparator("Title separator", variant: .bubble)
  }

  func bubbleView() -> some View {
    PBSectionSeparator(variant: .bubble)
  }

  func childrenView() -> some View {
    PBSectionSeparator(variant: .background) {
      PBIcon.fontAwesome(.arrowDown, size: .small)
      Text("Title")
        .pbFont(.title4)
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
