//
//  BadgeCatalog.swift
//
//
//  Created by Israel Molestina on 5/18/23.
//

import SwiftUI

public struct BadgeCatalog: View {

  public init() {}

  public var body: some View {
    List {
      Section("Rectangle") {
        HStack {
          PBBadge(text: "+1", variant: .primary)
          PBBadge(text: "+4", variant: .primary)
          PBBadge(text: "+1000", variant: .primary)
        }.padding(2)
      }

      Section("Rounded") {
        HStack {
          PBBadge(text: "+1", rounded: true, variant: .primary)
          PBBadge(text: "+4", rounded: true, variant: .primary)
          PBBadge(text: "+1000", rounded: true, variant: .primary)
        }.padding(2)
      }

      Section("Chat Notification") {
        HStack {
          PBBadge(text: "1", rounded: true, variant: .chat)
          PBBadge(text: "4", variant: .chat)
          PBBadge(text: "1000", variant: .chat)
        }.padding(2)
      }

      Section("Colors") {
        ForEach(PBBadge.Variant.allCases, id: \.self) { variant in
          HStack {
            PBBadge(text: "+1", rounded: true, variant: variant)
            PBBadge(text: "+4", variant: variant)
            PBBadge(text: "+1000", variant: variant)
          }.padding(2)
        }
      }
    }
  }
}
