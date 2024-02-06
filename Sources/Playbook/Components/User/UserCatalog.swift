//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  UserCatalog.swift
//

import SwiftUI

public struct UserCatalog: View {
  public var body: some View {
    let img = Image("andrew", bundle: .module)
    let name = "Andrew K"
    let title = "Rebels Developer"

    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Horizontal") {
          VStack(alignment: .leading, spacing: Spacing.small) {
            PBUser(
              name: name,
              image: img,
              territory: "PHL",
              title: title
            )
            PBUser(
              name: name,
              territory: "PHL",
              title: title
            )
            PBUser(
              name: name,
              image: img,
              size: .small,
              title: title
            )
            PBUser(
              name: name,
              image: img,
              size: .small
            )
          }
        }

        PBDoc(title: "Vertical") {
          VStack(alignment: .leading, spacing: Spacing.small) {
            PBUser(
              name: name,
              image: img,
              orientation: .vertical,
              size: .small,
              title: title
            )
            PBUser(
              name: name,
              image: img,
              orientation: .vertical,
              title: title
            )
            PBUser(
              name: name,
              image: img,
              orientation: .vertical,
              size: .large,
              title: title
            )
          }
        }

        PBDoc(title: "Text Only") {
          VStack(spacing: Spacing.small) {
            PBUser(
              name: name,
              displayAvatar: false,
              size: .large,
              territory: "PHL",
              title: title
            )
            PBUser(
              name: name,
              displayAvatar: false,
              territory: "PHL",
              title: title
            )
          }
        }

        PBDoc(title: "Horizontal Sizes") {
          VStack(alignment: .leading, spacing: Spacing.small) {
            PBUser(
              name: name,
              image: img,
              size: .small,
              territory: "PHL",
              title: title
            )
            PBUser(
              name: name,
              image: img,
              territory: "PHL",
              title: title
            )
            PBUser(
              name: name,
              image: img,
              size: .large,
              territory: "PHL",
              title: title
            )
          }
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("User")
  }
}
