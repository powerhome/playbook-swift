//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  CardCatalog.swift
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
    let defaultSection =  PBCard {
      Text(text).pbFont(.body)
    }
    let cardBackgrounds = VStack(alignment: .leading) {
      VStack(alignment: .leading, spacing: Spacing.small) {
        Text("Background Colors")
          .pbFont(.detail(true), color: .text(.default))

        ForEach(Color.BackgroundColor.allCases, id: \.self) { color in
          PBCard(backgroundColor: .background(color)) {
            Text(color.rawValue.capitalized).pbFont(.body, color: .text(.light))
          }
        }

        Text("Product Colors")
          .pbFont(.detail(true), color: .text(.default))

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

    let highlights = VStack(spacing: Spacing.small) {
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

    let headers = VStack(spacing: Spacing.small) {
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

    let styles = VStack(alignment: .leading, spacing: Spacing.small) {
      Text("Default").pbFont(.detail(true), color: .text(.default))
      PBCard {
        Text(text).pbFont(.body)
      }
      Text("Selected").pbFont(.detail(true), color: .text(.default))
      PBCard(style: .selected()) {
        Text(text).pbFont(.body)
      }
      Text("Error").pbFont(.detail(true), color: .text(.default))
      PBCard(style: .error) {
        Text(text).pbFont(.body)
      }
    }

    let padding =  VStack(spacing: Spacing.small) {
      ForEach(Spacing.allCase, id: \.0) { space in
        PBCard(padding: space.0) {
          Text(space.1).pbFont(.body)
        }
      }
    }

    let shadow = VStack(spacing: Spacing.small) {
      ForEach(Shadow.allCases, id: \.self) { shadow in
        PBCard(shadow: shadow) {
          Text(shadow.rawValue.capitalized).pbFont(.body)
        }
      }
    }

    let separator = PBCard(padding: Spacing.none) {
      Text("Header").pbFont(.body).padding(Spacing.small)
      PBSectionSeparator()
      Text(loremIpsum).pbFont(.body).padding(Spacing.small)
      PBSectionSeparator()
      Text("Footer").pbFont(.body).padding(Spacing.small)
    }

    let noborder = PBCard(border: false) {
      Text(text).pbFont(.body)
    }

    let border = VStack(spacing: Spacing.small) {
      ForEach(BorderRadius.allCase, id: \.1) { border in
        PBCard(borderRadius: border.0) {
          Text(border.1).pbFont(.body)
        }
      }
    }

    return ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") { defaultSection }
        PBDoc(title: "Card Backgrounds") { cardBackgrounds }
        PBDoc(title: "Highlight") { highlights }
        PBDoc(title: "Header Cards") { headers }
        PBDoc(title: "Styles") { styles }
        PBDoc(title: "Padding Size") { padding }
        PBDoc(title: "Shadow") { shadow }
        PBDoc(title: "Separator & Content") { separator }
        PBDoc(title: "No Border") { noborder }
        PBDoc(title: "Border Radius") { border }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Card")
  }
}
