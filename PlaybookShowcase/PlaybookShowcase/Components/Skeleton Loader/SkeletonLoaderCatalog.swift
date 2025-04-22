//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  SkeletonLoaderCatalog.swift
//

import SwiftUI
import Playbook

struct SkeletonLoaderCatalog: View {
  @State var isLoading: Bool = true
  @State var isLoading1: Bool = true
  @State var isLoading2: Bool = true
  @State var isLoading3: Bool = true
  @State var isLoading4: Bool = true
  @State var isLoading5: Bool = true
  @State var isLoading6: Bool = true
  @State var isLoading7: Bool = true
  @State var isLoading8: Bool = true
  var body: some View {
    PBDocStack(title: "Skeleton Loader") {
      PBDoc(title: "Member Card") {
        memberCardView
      }
    }
  }
}

extension SkeletonLoaderCatalog {
  @ViewBuilder
  var memberCardView: some View {
    PBCard(padding: Spacing.xSmall, width: 300) {

      PBSkeletonLoader(isLoading: $isLoading, shape: .rectangle(cornerRadius: 5), alignment: .center) {
        Text("Member Info")
      }

      PBSectionSeparator()
        .padding(.horizontal, -Spacing.xSmall)

      PBSkeletonLoader(isLoading: $isLoading1, shape: .circle, alignment: .leading) {
        PBAvatar(image: Image("andrew"), size: .large, status: .offline)
          .transaction { transaction in
              transaction.animation = nil
          }
      }

      VStack(spacing: Spacing.xxSmall) {
        PBSkeletonLoader(isLoading: $isLoading2, shape: .rectangle(cornerRadius: 5), alignment: .leading) {
          Text("Kraig Schwerin")
            .pbFont(.body, color: .text(.light))
        }

        PBSkeletonLoader(isLoading: $isLoading3, shape: .rectangle(cornerRadius: 5), alignment: .leading) {
          Text("Director of Nitro Support Services")
            .pbFont(.body, color: .text(.light))
        }

        PBSkeletonLoader(isLoading: $isLoading4, shape: .rectangle(cornerRadius: 5), alignment: .leading) {
          Text("PHL \u{2022} Business Technology")
            .pbFont(.subcaption)
        }
      }

      VStack(spacing: Spacing.small) {
        PBSkeletonLoader(isLoading: $isLoading5, shape: .rectangle(cornerRadius: 5), alignment: .leading) {
          PBContact(type: .email, value: "email@example.com")
          
        }

        PBSkeletonLoader(isLoading: $isLoading6, shape: .rectangle(cornerRadius: 5), alignment: .leading) {
          PBContact(type: .work, value: "3245627482")
        }

        PBSkeletonLoader(isLoading: $isLoading7, shape: .rectangle(cornerRadius: 5), alignment: .leading) {
          PBContact(type: .cell, value: "3491859988")
        }
      }

      Spacer()
      PBSkeletonLoader(isLoading: $isLoading8, shape: .rectangle(cornerRadius: 5), alignment: .center) {
        PBButton(variant: .secondary, size: .small, shape: .primary, title: "Direct Message", icon: PBIcon(FontAwesome.messages), iconPosition: .left, iconColor: .pbPrimary) {}

      }
    }
    .padding(Spacing.small)
  }
}

#Preview {

  SkeletonLoaderCatalog()
    .frame(height: 800)

}
