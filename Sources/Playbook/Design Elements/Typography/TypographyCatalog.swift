//
//  TypographyCatalog.swift
//
//
//  Created by Isis Silva on 23/05/23.
//

import SwiftUI

public struct TypographyCatalog: View {
  public var body: some View {
    let title = Section("Title") {
      Text("Title 1\nTitle 1")
        .pbFont(.title1)
      Text("Title 2\nTitle 2")
        .pbFont(.title2)
      Text("Title 3\nTitle 3")
        .pbFont(.title3)
      Text("Title 4\nTitle 4")
        .pbFont(.title4)
      Text("Title 4 Link Variant")
        .pbFont(.title4, variant: .link)
    }

    let body = Section("Body") {
      ForEach(TextSize.Body.allCases, id: \.rawValue) { size in
        Text("Body: Text size \(Int(size.rawValue)) px")
          .pbFont(.body(size))
          .padding(6)
      }
    }

    let letterSpacing = Section("Letter spacing") {
      ForEach(Typography.LetterSpacing.allCases, id: \.rawValue) { space in
        HStack {
          Text("Letter spacing")
          Spacer()
          Text(String(format: "%.2f", space.rawValue) + " px")
        }
        .pbFont(.body(), letterSpace: space)
      }
    }

    let componentsText = Section("Components Text") {
      Text("Button Text")
        .pbFont(.buttonText())
      Text("Badge Text")
        .pbFont(.badgeText)
    }

    let caption = Section("Caption") {
      Text("Large Caption")
        .pbFont(.largeCaption)
      Text("Caption")
        .pbFont(.caption)
      Text("Subcaption")
        .pbFont(.subcaption)
      Text("Subcaption Link Variant")
        .pbFont(.subcaption, variant: .link)
    }

    let detail = Section("Detail") {
      Text("I am a detail kit")
        .pbFont(.detail(false))
      
      Text("I am a detail kit")
        .pbFont(.detail(true))

    }

    return List {
      title
      body
      if #available(iOS 16.0, *) {
        letterSpacing
      }
      componentsText
      caption
      detail
    }
    .navigationTitle("Typography")
  }
}
