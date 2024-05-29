//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  TypographyCatalog.swift
//

import SwiftUI

public struct TypographyCatalog: View {
  public var body: some View {
    PBDocStack(title: "Typography") {
      PBDoc(title: "Title") { title }
      PBDoc(title: "Title Light Weight") { titleLight }
      PBDoc(title: "Text size") { textSize }
      PBDoc(title: "Letter spacing") { letterSpacing }
      PBDoc(title: "Components Text") { componentsText }
      PBDoc(title: "Caption") { caption }
      PBDoc(title: "Detail") { detail }
      PBDoc(title: "Message") { message }
    }
  }
}

private extension TypographyCatalog {
  var title: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
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
  
  var titleLight: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      Text("Title 1")
        .pbFont(.title1, variant: .light)
      Text("Title 2")
        .pbFont(.title2, variant: .light)
      Text("Title 3")
        .pbFont(.title3, variant: .light)
    }
  }
  
  var textSize: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      ForEach(TextSize.Body.allCases, id: \.rawValue) { size in
        Text("Text size \(Int(size.rawValue)) px")
          .pbFont(.monogram(size.rawValue))
      }
    }
  }
  
  var letterSpacing: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      ForEach(LetterSpacing.allCases, id: \.rawValue) { space in
        Text(space.rawValue).tracking(PBFont.body.space(space, font: .body))
      }
    }
  }
  
  var componentsText: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      Text("Button Text")
        .pbFont(.buttonText())
      Text("Badge Text")
        .pbFont(.badgeText)
    }
  }
  
  var caption: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      Text("Large Caption")
        .pbFont(.largeCaption)
      Text("Caption")
        .pbFont(.caption)
      Text("Subcaption")
        .pbFont(.subcaption)
      Text("Subcaption Link Variant")
        .pbFont(.subcaption, variant: .link)
    }
  }
  
  var detail: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      Text("I am a detail kit")
        .pbFont(.detail(false))
      Text("I am a detail kit")
        .pbFont(.detail(true))
    }
  }
  
  var message: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      Text("Message Title")
        .pbFont(.messageTitle)
      Text("Message Body")
        .pbFont(.messageBody)
    }
  }
}

#Preview {
  registerFonts()
  return TypographyCatalog()
}
