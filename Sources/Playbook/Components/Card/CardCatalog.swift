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
        VStack(alignment: .leading, spacing: 8) {
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
        VStack(alignment: .leading, spacing: 8) {
          PBCard(highlight: .side) {
            Text(text).pbFont(.body())
          }
          PBCard(highlight: .top, highlightColor: .status(.warning)) {
            Text(text).pbFont(.body())
          }
        }
      }

      Section("Header cards") {
        PBCard(padding: .pbNone) {
          PBCardHeader {
            Text(text).pbFont(.body()).padding(.pbSmall)
          }
          Text(text).pbFont(.body()).padding(.pbSmall)
        }
        PBCard(padding: .pbNone) {
          PBCardHeader(color: .product(.product2, category: .highlight)) {
            Text(text).pbFont(.body()).padding(.pbSmall)
          }
          Text(text).pbFont(.body()).padding(.pbSmall)
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
        PBCard(padding: .pbNone) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: .pbXsmall) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: .pbSmall) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: .pbMedium) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: .pbLarge) {
          Text(text).pbFont(.body())
        }
        PBCard(padding: .pbXlarge) {
          Text(text).pbFont(.body())
        }
      }
      .listRowSeparator(.hidden)

      Section("Separator & Content") {
        PBCard(padding: .pbNone) {
          Text("Header").pbFont(.body()).padding(.pbSmall)
          PBSectionSeparator()
          Text(loremIpsum).pbFont(.body()).padding(.pbSmall)
          PBSectionSeparator()
          Text("Footer").pbFont(.body()).padding(.pbSmall)
        }
      }

      Section("No border & border radius") {
        PBCard(border: false) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: .none) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: .xSmall) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: .small) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: .medium) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: .large) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: .xLarge) {
          Text(text).pbFont(.body())
        }
        PBCard(borderRadius: .rounded) {
          Text(text).pbFont(.body())
        }
      }
      .listRowSeparator(.hidden)

      Section("Complex") {
        PBCard(padding: .pbNone) {
          PBCardHeader(color: .product(.product1, category: .highlight)) {
            Text("Andrew")
              .pbFont(.body(), color: .text(.lighter))
              .padding(.pbSmall)
          }
          Image("andrew", bundle: .module)
            .resizable()
            .aspectRatio(contentMode: .fit)

          Text(loremIpsum).pbFont(.caption).padding(.pbSmall)
          PBSectionSeparator()
          Text("A nice guy and great dev").pbFont(.body()).padding(.pbSmall)
        }
      }
    }
  }
}
