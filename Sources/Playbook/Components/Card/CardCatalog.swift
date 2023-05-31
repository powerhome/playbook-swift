//
//  CardCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

@available(macOS 13.0, *)
public struct CardCatalog: View {
  let text = "Card Content"
  let loremIpsum =
    """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    Donec iaculis, risus a fringilla luctus, sapien eros sodales ex, quis molestie est nulla non turpis.
    Vestibulum aliquet at ipsum eget posuere. Morbi sed laoreet erat.
    Sed commodo posuere lectus, at porta nulla ornare a.
    """

  public init() {}

  public var body: some View {
    List {
      Section("Default") {
        VStack(alignment: .leading, spacing: Spacing.large) {
          Text("Default").pbFont(.caption)
          PBCard {
            Text(text).pbFont(.body())
          }
          .padding(.bottom)

          Text("Default with shadow deep").pbFont(.caption)
          PBCard(shadow: .deep) {
            Text(text).pbFont(.body())
          }
        }
      }

      Section("Highlight") {
        VStack(alignment: .leading, spacing: Spacing.large) {
          PBCard(highlight: .side) {
            Text(text).pbFont(.body())
          }
          PBCard(highlight: .top, highlightColor: .status(.warning)) {
            Text(text).pbFont(.body())
          }
        }
      }

      Section("Header cards") {
        PBCard(padding: Spacing.none) {
          PBCardHeader {
            Text(text).pbFont(.body()).padding(Spacing.small)
          }
          Text(text).pbFont(.body()).padding(Spacing.small)
        }
        PBCard(padding: Spacing.none) {
          PBCardHeader(color: .product(.product2, category: .highlight)) {
            Text(text).pbFont(.body()).padding(Spacing.small)
          }
          Text(text).pbFont(.body()).padding(Spacing.small)
        }
      }

      Section("Styles") {
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

      Section("Padding size") {
        PBCard(padding: Spacing.none) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: Spacing.xSmall) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: Spacing.small) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: Spacing.medium) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: Spacing.large) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: Spacing.xLarge) {
          Text(text).pbFont(.body())
        }
      }
      .listRowSeparator(.hidden)

      Section("Separator & Content") {
        PBCard(padding: Spacing.none) {
          Text("Header").pbFont(.body()).padding(Spacing.small)
          PBSectionSeparator()
          Text(loremIpsum).pbFont(.body()).padding(Spacing.small)
          PBSectionSeparator()
          Text("Footer").pbFont(.body()).padding(Spacing.small)
        }
      }

      Section("No border & border radius") {
        PBCard(border: false) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: BorderRadius.none) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: BorderRadius.xSmall) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: BorderRadius.small) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: BorderRadius.medium) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: BorderRadius.large) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: BorderRadius.xLarge) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: BorderRadius.rounded) {
          Text(text).pbFont(.body())
        }
      }
      .listRowSeparator(.hidden)

      Section("Complex") {
        PBCard(padding: Spacing.none) {
          PBCardHeader(color: .product(.product1, category: .highlight)) {
            Text("Andrew")
              .pbFont(.body(), color: .text(.lighter))
              .padding(Spacing.small)
          }
          Image("andrew", bundle: .module)
            .resizable()
            .aspectRatio(contentMode: .fit)

          Text(loremIpsum).pbFont(.caption).padding(Spacing.small)
          PBSectionSeparator()
          Text("A nice guy and great dev").pbFont(.body()).padding(Spacing.small)
        }
      }
    }
    .navigationTitle("Card")
  }
}
