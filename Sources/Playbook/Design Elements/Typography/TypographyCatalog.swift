//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  TypographyCatalog.swift
//

import SwiftUI
import playbook_icons

public struct TypographyCatalog: View {
  public var body: some View {
    let title = PBDoc(title: "Title") {
      VStack(alignment: .leading, spacing: Spacing.small) {
        Text("Title 1")
          .pbFont(.title1)
        Text("Title 2")
          .pbFont(.title2)
        Text("Title 3")
          .pbFont(.title3)
        Text("Title 4")
          .pbFont(.title4)
        Text("Title 4 Link Variant")
          .pbFont(.title4, variant: .link)
      }
    }

    let titleLight = PBDoc(title: "Title Light Weight") {
      VStack(alignment: .leading, spacing: Spacing.small) {
        Text("Title 1")
          .pbFont(.title1, variant: .light)
        Text("Title 2")
          .pbFont(.title2, variant: .light)
        Text("Title 3")
          .pbFont(.title3, variant: .light)
      }
    }

    let body = PBDoc(title: "Text size") {
      ForEach(TextSize.Body.allCases, id: \.rawValue) { size in
        Text("Text size \(Int(size.rawValue)) px")
          .pbFont(.monogram(size.rawValue))
          .padding(6)
      }
    }

    let letterSpacing = PBDoc(title: "Letter spacing") {
      ForEach(LetterSpacing.allCases, id: \.rawValue) { space in
        Text(space.rawValue).tracking(PBFont.body.space(space, font: .body))
      }
    }

    let componentsText = PBDoc(title: "Components Text") {
      Text("Button Text")
        .pbFont(.buttonText())
      Text("Badge Text")
        .pbFont(.badgeText)
    }

    let caption = PBDoc(title: "Caption") {
      Text("Large Caption")
        .pbFont(.largeCaption)
      Text("Caption")
        .pbFont(.caption)
      Text("Subcaption")
        .pbFont(.subcaption)
      Text("Subcaption Link Variant")
        .pbFont(.subcaption, variant: .link)
    }

    let detail = PBDoc(title: "Detail") {
      Text("I am a detail kit")
        .pbFont(.detail(false))
      Text("I am a detail kit")
        .pbFont(.detail(true))
    }
    
    let power = PBDoc(title: "Power Fonts") {
      Text("I am a Power Centra Font")
        .font(.custom(PowerCentra.boldit.rawValue, size: 34))
    }

    return ScrollView {
      VStack(spacing: Spacing.medium) {
        title
        titleLight
        body
        letterSpacing
        componentsText
        caption
        detail
        power
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Typography")
  }
}
