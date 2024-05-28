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
    PBDocStack(title: "User") {
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
      
      PBDoc(title: "Presence Indicator") {
        presenceIndicatorView
      }
    }
  }
}

public extension UserCatalog {
  var userHorizontalView: some View {
    return VStack(alignment: .leading, spacing: Spacing.small) {
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
  var userHorizontalSizesView: some View {
    return VStack(alignment: .leading, spacing: Spacing.small) {
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
  var roleSubtitle: AnyView {
    AnyView(
      HStack {
        PBIcon(FontAwesome.users, size: .small)
        Text("ADMIN").pbFont(.caption, color: .text(.light))
      }
    )
  }
  var contactSubtitle: AnyView {
    let contacts = [
      PBContact(type: .cell, value: "(349) 185-9988", detail: false),
      PBContact(type: .home, value: "(555) 555-5555", detail: false),
      PBContact(type: .email, value: "email@example.com", detail: false)
    ]
    return AnyView (
      ForEach(contacts, id: \.parsedValue) { contact in
        PBContact(type: contact.type, value: contact.contactValue, detail: contact.detail)
      }
    )
  }
  var userSubtitleBlockView: some View {
    return VStack(alignment: .leading, spacing: Spacing.small) {
      PBUser(
        name: "Anna Black",
        image: Image("Anna", bundle: .module),
        size: .small, 
        territory: "PHL",
        title: "Remodeling Consultant",
        subtitle: roleSubtitle
      )
      PBUser(
        name: "Anna Black",
        image: Image("Anna", bundle: .module),
        size: .small,
        subtitle: contactSubtitle
      )
    }
  }
  var presenceIndicatorView: some View {
    return VStack(alignment: .leading, spacing: Spacing.small) {
      PBUser(
        name: name,
        image: img,
        size: .small,
        territory: "PHL",
        title: title,
        status: .online
      )
      PBUser(
        name: name,
        image: img,
        territory: "PHL",
        title: title,
        status: .away
      )
      PBUser(
        name: name,
        image: img,
        size: .large,
        territory: "PHL",
        title: title,
        status: .offline
      )
    }
  }
}
