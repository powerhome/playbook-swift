//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  MasonryCatalog.swift
//

import SwiftUI
import Playbook

public struct MasonryCatalog: View {
  @State var spaceImages = Mocks.spaceImages

  public var body: some View {
    PBDocStack(title: "Masonry") {
      PBDoc(title: "Default") {
          imageMasonryView
      }
    }
  }
}

extension MasonryCatalog {
  var imageMasonryView: some View {
    PBMasonry(numOfColumns: 3, horizontalSpacing: 10, verticalSpacing: 10, items: spaceImages) { item in
     Image(item)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .zIndex(-2)
        .clipped()
    }
  }
}

#Preview {
  MasonryCatalog()
}
