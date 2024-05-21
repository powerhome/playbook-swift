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
  @State private var isSelected4: Bool = true
  @State private var isSelected5: Bool = true
  @State private var isSelected6: Bool = false
  @State private var isSelected7: Bool = false
  @State private var radioItem: String = "5"
  @State private var radioItemSelected: PBRadioItem? = PBRadioItem("")
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
//          PBDoc(title: "Input") {
//            checkedInputView
//          }
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
  var checkedInputView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      PBSelectableCard(
        variant: .checkedInput,
        cardText: "Ruby",
        isSelected: $isSelected4
      )
      PBSelectableCard(
        variant: .checkedInput,
        cardText: "JavaScript",
        isSelected: $isSelected5
      )
      PBSelectableCard(
        variant: .checkedInput,
        cardText: "TypeScript",
        isSelected: $isSelected6
      )
      PBSelectableCard(
        variant: .checkedInput,
        cardText: "Swift",
        isSelected: $isSelected7
      )
      PBSelectableCard(
        variant: .radioInput,
        radioItem: $radioItem,
        isRadioSelected: $radioItemSelected
      )
    }
  }
}
