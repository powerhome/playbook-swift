//
//  CollapsibleCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct CollapsibleCatalog: View {

  public init() {}

  @State var isCollapsed = false
  @State var isCollapsedTrailing = true
  @State var isCollapsedImage = true

  let lorem =
    """
    Group members... Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vel erat sed purus hendrerit vive.

    Etiam nunc massa, pharetra vel quam id, posuere rhoncus quam. Quisque imperdiet arcu enim, nec aliquet justo.

    Praesent lorem arcu. Vivamus suscipit, libero eu fringilla egestas, orci urna commodo arcu, vel gravida turpis.
    """

  var header: some View {
    Label(
      title: { Text("Title with Icon, Chevron Left") },
      icon: { PBIcon.fontAwesome(.users) }
    )
  }

  var textOnlyHeader: some View {
    Text("Title with Only Text, Chevron Right")
  }

  var imageHeader: some View {
    Text("Image")
  }

  var content: some View {
    Text(lorem)
  }

  var image: some View {
    PBImage(
      image: Image("Forest", bundle: .module),
      size: .none
    )
  }

  public var body: some View {
    GeometryReader { _ in
      VStack {
        PBCollapsible(isCollapsed: $isCollapsed) {
          header
        } content: {
          content
        }

        PBCollapsible(isCollapsed: $isCollapsedTrailing, indicatorPosition: .trailing) {
          textOnlyHeader
        } content: {
          content
        }

        PBCollapsible(isCollapsed: $isCollapsedImage, indicatorPosition: .trailing) {
          imageHeader
        } content: {
          image
        }
      }
      .padding()
    }
  }
}
