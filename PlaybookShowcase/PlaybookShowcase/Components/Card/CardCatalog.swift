//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  CardCatalog.swift
//

import SwiftUI
import Playbook

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
    PBDocStack(title: "Card") {
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
  }
}

extension CardCatalog {
  var defaultSection: some View {
    PBCard { Text(text).pbFont(.body) }
  }

  var cardBackgrounds: some View {
    VStack(alignment: .leading) {
      VStack(alignment: .leading, spacing: Spacing.small) {
        Text("Background Colors")
          .pbFont(.detail(true), color: .text(.default))
        PBCard(backgroundColor: .background(.dark)) {
          Text("Dark").pbFont(.body, color: .white)
        }
        PBCard {
          Text("Default").pbFont(.body)
        }
        PBCard(backgroundColor: .background(.light)) {
          Text("Light").pbFont(.body, color: Color(hex: "#242b42"))
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
  }

  var highlights: some View {
    VStack(spacing: Spacing.small) {
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
  }

  var headers: some View {
    VStack(spacing: Spacing.small) {
      PBCard(padding: Spacing.none) {
        PBCardHeader(color: .category(.category1), borderRadius: BorderRadius.medium) {
          Text("Category 1").pbFont(.body, color: .white).padding(Spacing.small)
        }
        Text("Body").pbFont(.body, color: .text(.default)).padding(Spacing.small)
      }

      PBCard(padding: Spacing.none) {
        PBCardHeader(color: .category(.category3), borderRadius: BorderRadius.medium) {
          Text("Category 3").pbFont(.body, color: .black).padding(Spacing.small)
        }
        Text("Body").pbFont(.body, color: .text(.default)).padding(Spacing.small)
      }

      PBCard(padding: Spacing.none) {
        PBCardHeader(color: .product(.product2, category: .background), borderRadius: BorderRadius.medium) {
          Text("Product 2 Background").pbFont(.body, color: .white).padding(Spacing.small)
        }
        Text("Body").pbFont(.body, color: .text(.default)).padding(Spacing.small)
      }

      PBCard(padding: Spacing.none) {
        PBCardHeader(color: .product(.product6, category: .background), borderRadius: BorderRadius.medium) {
          Text("Product 6 Background").pbFont(.body, color: .white).padding(Spacing.small)
        }
        Text("Body").pbFont(.body, color: .text(.default)).padding(Spacing.small)
      }
    }
  }

  var styles: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
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
  }

  var padding: some View {
    VStack(spacing: Spacing.small) {
      ForEach(Spacing.allCase, id: \.0) { space in
        PBCard(padding: space.0) {
          Text(space.1).pbFont(.body)
        }
      }
    }
  }

  var shadow: some View {
    VStack(spacing: Spacing.small) {
      PBCard(shadow: .deep) {
        Text("Deep")
      }
      PBCard(shadow: .deeper) {
        Text("Deeper")
      }
      PBCard(shadow: .deepest) {
        Text("Deepest")
      }
      PBCard(shadow: Shadow.none) {
        Text("None")
      }
    }
    .pbFont(.body)
  }

  var separator: some View {
    PBCard(padding: Spacing.none) {
      Text("Header").pbFont(.body).padding(Spacing.small)
      PBSectionSeparator()
      Text(loremIpsum).pbFont(.body).padding(Spacing.small)
      PBSectionSeparator()
      Text("Footer").pbFont(.body).padding(Spacing.small)
    }
  }

  var noborder: some View {
    PBCard(border: false) {
      Text(text).pbFont(.body)
    }
  }

  var border: some View {
    VStack(spacing: Spacing.small) {
      ForEach(BorderRadius.allCase, id: \.1) { border in
        PBCard(borderRadius: border.0) {
          Text(border.1).pbFont(.body)
        }
      }
    }
  }
}

#Preview {
  registerFonts()
  return CardCatalog()
}
