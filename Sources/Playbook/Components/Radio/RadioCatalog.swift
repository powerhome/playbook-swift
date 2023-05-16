//
//  RadioCatalog.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct RadioCatalog: View {
  @State var selected: PBRadioItem? = PBRadioItem("Manor", subtitle: "subtitle")
  var orientation: Orientation = .vertical

  public init(selected: PBRadioItem? = nil, orientation: Orientation = .vertical) {
    self.selected = selected
    self.orientation = orientation
  }

  public var body: some View {
    List {
      Section("Vertical") {
        contentView(orientation: .vertical)
      }

      Section("Horizontal") {
        ScrollView(.horizontal) {
          contentView(orientation: .horizontal)
        }
      }
    }
  }

  func contentView(orientation: Orientation) -> some View {
    VStack(alignment: .leading) {
      PBRadio(
        items: [
          PBRadioItem("Manor", subtitle: "subtitle"),
          .init("Chalet"),
          .init("Ranch"),
          .init("Villa")
        ],
        orientation: orientation,
        selected: $selected
      )

      if let selected = selected {
        Text("You selected: \(selected.title)")
      }
    }
  }
}
