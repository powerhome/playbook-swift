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
        Text(text).pbFont(.body)
      }
    }

    let cardBackgrounds = Section("Card Backgrounds") {
      VStack(alignment: .leading) {
        Text("Background Colors")
          .pbFont(.caption)
          .padding(.vertical)
        ForEach(Color.BackgroundColor.allCases, id: \.self) { color in
          PBCard(backgroundColor: .background(color)) {
            Text(color.rawValue.capitalized).pbFont(.body, color: .text(.light))
          }
        }
        PBSectionSeparator()
        Text("Product Colors")
          .pbFont(.caption)
          .padding(.vertical)

        PBCard(backgroundColor: .product(.product1, category: .background)) {
          Text("Product 1 Background").pbFont(.body, color: .white)
        }

        PBCard(backgroundColor: .product(.product7, category: .highlight)) {
          Text("Product 7 Highlight").pbFont(.body, color: .white)
        }

        PBCard(backgroundColor: .product(.product2, category: .highlight)) {
          Text("Product 2 Highlight").pbFont(.body, color: .white)
        }
      }
    }

    let highlights = Section("Highlight") {
      PBCard(highlight: .side(.product(.product6, category: .highlight))) {
        Text("Side Position & Product 6 Highlight Color").pbFont(.body)
      }

      PBCard(highlight: .top(.status(.warning))) {
        Text("Top Position & Warning Color").pbFont(.body)
      }

      PBCard(highlight: .side(.category(.category2))) {
        Text("Side Position & Category 2 Color").pbFont(.body)
      }
    }
    .listRowSeparator(.hidden)

    let headers = Section("Header cards") {
      VStack {
        PBCard(padding: Spacing.none) {
          PBCardHeader(color: .category(.category1)) {
            Text("Category 1").pbFont(.body, color: .white).padding(Spacing.small)
          }
          Text("Body").pbFont(.body, color: .text(.default)).padding(Spacing.small)
        }

        PBCard(padding: Spacing.none) {
          PBCardHeader(color: .category(.category3)) {
            Text("Category 3").pbFont(.body, color: .black).padding(Spacing.small)
          }
          Text("Body").pbFont(.body, color: .text(.default)).padding(Spacing.small)
        }

        PBCard(padding: Spacing.none) {
          PBCardHeader(color: .product(.product2, category: .background)) {
            Text("Product 2 Background").pbFont(.body, color: .white).padding(Spacing.small)
          }
          Text("Body").pbFont(.body, color: .text(.default)).padding(Spacing.small)
        }

        PBCard(padding: Spacing.none) {
          PBCardHeader(color: .product(.product6, category: .background)) {
            Text("Product 6 Background").pbFont(.body, color: .white).padding(Spacing.small)
          }
          Text("Body").pbFont(.body, color: .text(.default)).padding(Spacing.small)
        }
      }
    }

    let styles = Section("Styles") {
      VStack(alignment: .leading, spacing: nil) {
        Text("Default").pbFont(.caption)
        PBCard {
          Text(text).pbFont(.body)
        }
        Text("Selected").pbFont(.caption)
        PBCard(style: .selected) {
          Text(text).pbFont(.body)
        }
        Text("Error").pbFont(.caption)
        PBCard(style: .error) {
          Text(text).pbFont(.body)
        }
      }
    }

    let padding =  Section("Padding size") {
      ForEach(Spacing.allCase, id: \.0) { space in
        PBCard(padding: space.0) {
          Text(space.1).pbFont(.body)
        }
      }
    }
    .listRowSeparator(.hidden)

    let separator = Section("Separator & Content") {
      PBCard(padding: Spacing.none) {
        Text("Header").pbFont(.body).padding(Spacing.small)
        PBSectionSeparator()
        Text(loremIpsum).pbFont(.body).padding(Spacing.small)
        PBSectionSeparator()
        Text("Footer").pbFont(.body).padding(Spacing.small)
      }
    }

    let shadow = Section("Shadow") {
      ForEach(Shadow.allCases, id: \.self) { shadow in
        PBCard(shadow: shadow) {
          Text(shadow.rawValue.capitalized).pbFont(.body)
        }
      }
    }
    .listRowSeparator(.hidden)

    let noborder = Section("No border") {
      PBCard(border: false) {
        Text(text).pbFont(.body)
      }
    }

    let border = Section("Border radius") {
      ForEach(BorderRadius.allCase, id: \.1) { border in
        PBCard(borderRadius: border.0) {
          Text(border.1).pbFont(.body)
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
      noborder
      border
    }
    .navigationTitle("Card")
  }
}
