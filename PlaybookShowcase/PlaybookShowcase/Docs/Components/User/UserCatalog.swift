//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  UserCatalog.swift
//

import SwiftUI
import Playbook

public struct UserCatalog: View {
  let img = Image("Anna")
  let name = "Anna Black"
  let title = "Remodeling Consultant"

  public var body: some View {
    PBDocStack(title: "User") {
      PBDoc(title: "Default") { defaultView }
      PBDoc(title: "With Territory") { withTerritoryView }
      PBDoc(title: "Text Only") { textOnlyView }
      PBDoc(title: "Horizontal Size") { horizontalSizeView }
      PBDoc(title: "Vertical Size") { verticalSizeView }
      PBDoc(title: "Subtitle") { subtitleView }
      PBDoc(title: "Block Content Subtitle") { subtitleBlockContentView }
      PBDoc(title: "Presence Indicator") { presenceIndicatorView }
      PBDoc(title: "Custom Title Font") { customFontsView }
    }
  }
}

public extension UserCatalog {
  var defaultView: some View {
    return Stack {
      PBUser(
        name: name,
        image: img,
        orientation: .vertical,
        size: .large,
        title: title
      )
      PBUser(
        name: name,
        image: img,
        size: .small,
        title: title
      )
      VStack {
        PBUser(
          name: name,
          image: img,
          size: .small
        )
        PBUser(
          name: name,
          size: .small
        )
      }
    }
  }

  var withTerritoryView: some View {
    return Stack {
      PBUser(
        name: name,
        image: img,
        orientation: .vertical,
        size: .large,
        territory: "PHL",
        title: title
      )
      PBUser(
        name: name,
        image: img,
        size: .small,
        territory: "PHL",
        title: title
      )
      VStack {
        PBUser(
          name: name,
          size: .large,
          territory: "PHL",
          title: title,
          displayAvatar: false
        )
        PBUser(
          name: name,
          size: .small,
          territory: "PHL",
          title: title,
          displayAvatar: false
        )
      }
    }
  }

  var textOnlyView: some View {
    return Stack {
      PBUser(
        name: name,
        size: .large,
        title: title,
        displayAvatar: false
      )
      PBUser(
        name: name,
        size: .small,
        title: title,
        displayAvatar: false
      )
    }
  }

  var horizontalSizeView: some View {
    return Stack {
      ForEach(PBUser.Size.allCases, id: \.self) { size in
        PBUser(
          name: name,
          image: img,
          orientation: .horizontal,
          size: size,
          title: title
        )
      }
    }
  }

  var verticalSizeView: some View {
    return Stack {
      ForEach(PBUser.Size.allCases, id: \.self) { size in
        PBUser(
          name: name,
          image: img,
          orientation: .vertical,
          size: size,
          title: title
        )
      }
    }
  }

  var subtitleView: some View {
    return Stack {
      PBUser(
        name: name,
        image: img,
        orientation: .vertical,
        size: .medium,
        territory: "PHL",
        title: title,
        subtitle: textSubtitle
      )
      PBUser(
        name: name,
        image: img,
        orientation: .horizontal,
        size: .medium,
        territory: "PHL",
        title: title,
        subtitle: textSubtitle
      )
    }
  }

  var subtitleBlockContentView: some View {
    return Stack {
      PBUser(
        name: name,
        image: img,
        orientation: .vertical,
        size: .medium,
        territory: "PHL",
        title: title,
        subtitle: roleSubtitle
      )
      PBUser(
        name: name,
        image: img,
        orientation: .horizontal,
        size: .medium,
        territory: "PHL",
        title: title,
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

  var textSubtitle: AnyView {
    return AnyView(
      Text("USer ID: 12345")
        .pbFont(.body, color: .text(.light))
    )
  }

  var roleSubtitle: AnyView {
    return AnyView(
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

  var customFontsView: some View {
    return Stack {
      PBUser(
        name: name,
        nameFont: .init(font: .title3, variant: .light),
        image: img,
        orientation: .vertical,
        size: .large,
        title: title
      )
      PBUser(
        name: name,
        nameFont: .init(font: .title2, variant: .light),
        image: img,
        size: .small,
        title: title
      )
      VStack {
        PBUser(
          name: name,
          nameFont: .init(font: .title4, variant: .light),
          image: img,
          size: .small
        )
        PBUser(
          name: name,
          nameFont: .init(font: .body, variant: .light),
          size: .small
        )
      }
    }
  }
}

#Preview {
  UserCatalog()
}
