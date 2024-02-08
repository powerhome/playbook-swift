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
  let img = Image("andrew", bundle: .module)
  let name = "Andrew K"
  let title = "Rebels Developer"
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Horizontal") {
          userHorizontalView
        }

        PBDoc(title: "Vertical") {
          userVerticalView
        }

        PBDoc(title: "Text Only") {
          userTextOnlyView
        }

        PBDoc(title: "Horizontal Sizes") {
          userHorizontalSizesView
        }
        
        PBDoc(title: "Block Content Subtitle") {
          userSubtitleBlockView
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("User")
  }
}

public extension UserCatalog {
  var userHorizontalView: some View {
    return VStack(alignment: .leading, spacing: Spacing.small) {
      PBUser(
        name: name,
        image: img,
        territory: "PHL",
        title: title,
        subtitle: .none
      )
      PBUser(
        name: name,
        territory: "PHL",
        title: title,
        subtitle: .none
      )
      PBUser(
        name: name,
        image: img,
        size: .small,
        title: title,
        subtitle: .none
      )
      PBUser(
        name: name,
        image: img,
        size: .small,
        subtitle: .none
      )
    }
  }
  
  var userVerticalView: some View {
    return VStack(alignment: .leading, spacing: Spacing.small) {
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
  
  var userTextOnlyView: some View {
    return VStack(spacing: Spacing.small) {
      PBUser(
        name: name,
        displayAvatar: false,
        size: .large,
        territory: "PHL",
        title: title,
        subtitle: .none
      )
      PBUser(
        name: name,
        displayAvatar: false,
        territory: "PHL",
        title: title,
        subtitle: .none
      )
    }
  }
  
  var userHorizontalSizesView: some View {
    return VStack(alignment: .leading, spacing: Spacing.small) {
      PBUser(
        name: name,
        image: img,
        size: .small,
        territory: "PHL",
        title: title,
        subtitle: .none
      )
      PBUser(
        name: name,
        image: img,
        territory: "PHL",
        title: title,
        subtitle: .none
      )
      PBUser(
        name: name,
        image: img,
        size: .large,
        territory: "PHL",
        title: title,
        subtitle: .none
      )
    }
  }
  
  var userSubtitleBlockView: some View {
    return VStack(alignment: .leading, spacing: Spacing.small) {
      PBUser(
        name: "Anna Black",
        image: Image("Anna", bundle: .module),
        size: .small, 
        territory: "PHL",
        title: "Remodeling Consultant",
        subtitle: .iconTitle
      )
      PBUser(
        name: "Anna Black",
        image: Image("Anna", bundle: .module),
        size: .small,
        subtitle: .contact
      )
    }
  }
}
