//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  SelectableCardCatalog.swift
//

import SwiftUI

public struct SelectableCardCatalog: View {
  @State private var isSelected: Bool = true
  @State private var isSelected1: Bool = true
  @State private var isSelected2: Bool = false
  @State private var isSelected3: Bool = true
  @State private var hasIcon: Bool = true
  @State private var isDisabled: Bool = true
  @State private var isHovering: Bool = false
    public var body: some View {
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Default") {
            defaultView
          }

          PBDoc(title: "Block") {
            blockView
          }
        }
        .padding(Spacing.medium)
      }
      .background(Color.background(Color.BackgroundColor.light))
      .navigationTitle("Selectable Card")
    }
}

public extension SelectableCardCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBSelectableCard(
        cardText: "Selected, with icon",
        isSelected: $isSelected,
        hasIcon: $hasIcon
      )
      PBSelectableCard(
        cardText: "Selected, without icon",
        isSelected: $isSelected1
      )
      PBSelectableCard(
        cardText: "Unselected", 
        isSelected: $isSelected2
      )
      PBSelectableCard(
        cardText: "Disabled",
        isDisabled: $isDisabled
      )
    }
  }
  var blockView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBSelectableCard(
        variant: .block,
        cardText: "Block \nThis uses block",
        isSelected: $isSelected3
      )
    }
  }
}
