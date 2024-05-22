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
  @State private var isSelected8: Bool = false
  @State private var isSelected9: Bool = false
  @State private var isSelected10: Bool = false
  @State private var isSelected11: Bool = false
  @State private var isSelected12: Bool = false
  @State private var radioItem: String = "4"
  @State private var radioItem1: String = "5"
  @State private var radioItemSelected: PBRadioItem? = PBRadioItem("")
  @State private var radioItemSelected1: PBRadioItem? = PBRadioItem("")
  @State private var hasIcon: Bool = true
  @State private var isDisabled: Bool = true
  @State private var isHovering: Bool = false
    public var body: some View {
      ScrollView {
        VStack(spacing: Spacing.medium) {
//          PBDoc(title: "Default") {
//            defaultView
//          }
//
//          PBDoc(title: "Block") {
//            blockView
//          }
          PBDoc(title: "Input") {
            inputView
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
  var inputView: some View {
    VStack(alignment: .leading, spacing: Spacing.medium) {
      Text("What programming languages do you know?")
        .pbFont(.title3, variant: .bold, color: .text(.default))
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
      Spacer()
      Text("How likely are you to recommend Playbook to a friend?")
        .pbFont(.title3)
      PBSelectableCard(
        variant: .radioInput,
        cardText: "5",
       isSelected: $isSelected8
      )
      PBSelectableCard(
        variant: .radioInput,
        cardText: "4",
       isSelected: $isSelected9
      )
      PBSelectableCard(
        variant: .radioInput,
        cardText: "3",
       isSelected: $isSelected10
      )
      PBSelectableCard(
        variant: .radioInput,
        cardText: "2",
       isSelected: $isSelected11
      )
      PBSelectableCard(
        variant: .radioInput,
        cardText: "1",
       isSelected: $isSelected12
      )
    }
  }
}
