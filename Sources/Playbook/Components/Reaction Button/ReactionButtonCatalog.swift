//
//  ReactionButtonCatalog.swift
//  
//
//  Created by Rachel Radford on 11/26/23.
//

import SwiftUI

struct ReactionButtonCatalog: View {
  @State private var count: Int? = 153
  @State private var count1: Int? = 5

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: Spacing.xxSmall) {
        PBDoc(title: "Reaction Button") {
          reactionButtonView
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Reaction Button")
  }
}

extension ReactionButtonCatalog {
  var reactionButtonView: some View {
    return HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10) {
      PBReactionButton(count: $count, icon: "\u{1F389}", variant: .emoji)
      PBReactionButton(count: $count1, icon: "1️⃣", variant: .emoji)
      PBReactionButton(variant: .emoji)
      PBReactionButton(pbIcon: PBIcon(FontAwesome.user), variant: .defaultIcon)
    }
  }
}
