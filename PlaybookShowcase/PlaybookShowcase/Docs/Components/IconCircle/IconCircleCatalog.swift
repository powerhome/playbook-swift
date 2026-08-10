//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  IconCircleCatalog.swift
//

import SwiftUI
import Playbook

public struct IconCircleCatalog: View {
  public var body: some View {
    PBDocStack(title: "Icon Circle") {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Size") {
        sizeView
      }
      PBDoc(title: "Color") {
        colorView
      }
    }
  }
}

extension IconCircleCatalog {
  var defaultView: some View {
    PBIconCircle(Icons.rocket)
  }
  var sizeView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      let pBIconSizes = [PBIcon.IconSize.small, PBIcon.IconSize.x1, PBIcon.IconSize.large]

      ForEach(pBIconSizes, id: \.self) { size in
        PBIconCircle(Icons.rocket, size: size)
      }
    }
  }
  var colorView: some View {
    VStack(spacing: Spacing.small) {
      ForEach(Color.DataColor.allCases, id: \.self) { color in
        PBIconCircle(Icons.rocket, size: .small, color: Color.data(color))
      }
    }
  }
}
