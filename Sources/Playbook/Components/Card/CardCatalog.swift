//
//  CardCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct CardCatalog: View {
  let text = "Card Content"
  let loremIpsum =
    """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    Donec iaculis, risus a fringilla luctus, sapien eros sodales ex, quis molestie est nulla non turpis.
    Vestibulum aliquet at ipsum eget posuere. Morbi sed laoreet erat.
    Sed commodo posuere lectus, at porta nulla ornare a.
    """

  public var body: some View {
    let defaultSection =  Section("Default") {
      PBCard {
        Text(text).pbFont(.body())
      }
    }

    let cardBackgrounds = Section("Card Backgrounds") {
      VStack(alignment: .leading) {
        Text("Background Colors")
          .pbFont(.caption)
          .padding(.vertical)
        ForEach(Color.BackgroundColor.allCases, id: \.self) { color in
          PBCard(backgroundColor: .background(color)) {
            Text(color.rawValue.capitalized).pbFont(.body(), color: .text(.light))
          }
        }
        PBSectionSeparator()
        Text("Product Colors")
          .pbFont(.caption)
          .padding(.vertical)
        ForEach(Color.ProductColor.allCases, id: \.self) { color in
          PBCard(backgroundColor: .product(color, category: .background)) {
            Text(color.rawValue.capitalized).pbFont(.body(), color: .white)
          }
        }
      }
    }

    let highlights = Section("Highlight") {
      ForEach(Color.DataColor.allCases, id: \.self) { color in
        PBCard(highlight: .side(.data(color))) {
          Text(text).pbFont(.body())
        }

        PBCard(highlight: .top(.data(color))) {
          Text(color.rawValue.capitalized).pbFont(.body())
        }
      }
    }
      .listRowSeparator(.hidden)

    let headers = Section("Header cards") {
      ForEach(Color.DataColor.allCases, id: \.self) { color in
        PBCard(padding: Spacing.none) {
          PBCardHeader(color: .data(color)) {
            Text(color.rawValue.capitalized).pbFont(.body(), color: .white).padding(Spacing.small)
          }
          Text(text).pbFont(.body(), color: .text(.default)).padding(Spacing.small)
        }
      }
    }

    let styles = Section("Styles") {
      VStack(alignment: .leading, spacing: nil) {
        Text("Default").pbFont(.caption)
        PBCard {
          Text(text).pbFont(.body())
        }
        Text("Selected").pbFont(.caption)
        PBCard(style: .selected) {
          Text(text).pbFont(.body())
        }
        Text("Error").pbFont(.caption)
        PBCard(style: .error) {
          Text(text).pbFont(.body())
        }
      }
    }

    let padding =  Section("Padding size") {
      ForEach(Spacing.allCase, id: \.0) { space in
        PBCard(padding: space.0) {
          Text(space.1).pbFont(.body())
        }
      }
    }
      .listRowSeparator(.hidden)

    let separator = Section("Separator & Content") {
      PBCard(padding: Spacing.none) {
        Text("Header").pbFont(.body()).padding(Spacing.small)
        PBSectionSeparator()
        Text(loremIpsum).pbFont(.body()).padding(Spacing.small)
        PBSectionSeparator()
        Text("Footer").pbFont(.body()).padding(Spacing.small)
      }
    }

    let shadow = Section("Shadow") {
      ForEach(Shadow.allCases, id: \.self) { shadow in
        PBCard(shadow: shadow) {
          Text(shadow.rawValue.capitalized).pbFont(.body())
        }
      }
    }
      .listRowSeparator(.hidden)

    let border = Section("No border & border radius") {
      ForEach(BorderRadius.allCase, id: \.1) { border in
        PBCard(borderRadius: border.0) {
          Text(border.1).pbFont(.body())
        }
      }
    }
      .listRowSeparator(.hidden)

    return List {
      defaultSection
      cardBackgrounds
      highlights
      headers
      styles
      padding
      shadow
      separator
      border
    }
    .navigationTitle("Card")
  }
}
