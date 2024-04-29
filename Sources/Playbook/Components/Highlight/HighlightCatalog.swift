//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  HighlightCatalog.swift
//

import SwiftUI

struct HighlightCatalog: View {
    var body: some View {
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Default") {
            defaultView
          }
        }
        .padding(Spacing.medium)
      }
      .navigationTitle("Highlight")
    }
}
 
extension HighlightCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBHighlight(
        text: "This is the Highlight Kit.",
        highlightedText: ["Highlight Kit"]
      )
    }
  }
}
