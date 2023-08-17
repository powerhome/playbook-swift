//
//  CollapsibleCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct CollapsibleCatalog: View {
  struct CollapsibleDoc: View {
    let text: String
    @State var isCollapsed = true

    var content: some View {
      Text(lorem).pbFont(.body)
    }

    let lorem =
      """
      Group members... Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vel erat sed purus hendrerit vive.

      Etiam nunc massa, pharetra vel quam id, posuere rhoncus quam. Quisque imperdiet arcu enim, nec aliquet justo.

      Praesent lorem arcu. Vivamus suscipit, libero eu fringilla egestas, orci urna commodo arcu, vel gravida turpis.
      """

    public init(
      text: String
    ) {
      self.text = text
    }

    var body: some View {
      PBCollapsible(isCollapsed: $isCollapsed) {
        Text(text).pbFont(.body)
      } content: {
        content
      }
    }
  }

  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          CollapsibleDoc(text: "Main Section")
        }

        PBDoc(title: "Size") {
          VStack(spacing: Spacing.medium) {
            CollapsibleDoc(text: "Extra Small Section")
            CollapsibleDoc(text: "Small Section")
            CollapsibleDoc(text: "Default Section")
            CollapsibleDoc(text: "Large Section")
          }
        }

        PBDoc(title: "Color") {
          VStack(spacing: Spacing.medium) {
            CollapsibleDoc(text: "Default Section")
            CollapsibleDoc(text: "Light Section")
            CollapsibleDoc(text: "Lighter Section")
            CollapsibleDoc(text: "Link Section")
            CollapsibleDoc(text: "Error Section")
            CollapsibleDoc(text: "Success Section")
          }
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Collapsible")
  }
}
