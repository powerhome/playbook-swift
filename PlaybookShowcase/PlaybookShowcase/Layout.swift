//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Layout.swift
//

import SwiftUI
import Playbook

struct LayoutView: View {
  let users = Mocks.multipleUsersGroup
  @State var selectedLayout: Int = Layout.classic.index

  var body: some View {
    VStack(alignment: .leading, spacing: Spacing.none) {
      PBNav(selected: $selectedLayout, variant: .subtle, orientation: .horizontal, borders: false, highlight: false) {
        PBNavItem(Layout.classic.title)
        PBNavItem(Layout.cozy.title)
      }
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBCollapsible(
            isCollapsed: true,
            iconSize: .small,
            iconColor: .lighter,
            actionButton: PBButton(variant: .link, icon: PBIcon.fontAwesome(.plus)) {}
          ) {
            Text("Rooms").pbFont(.body)
            Spacer()
          } content: {
            roomContent
          }
          PBCollapsible(
            isCollapsed: false,
            iconSize: .small,
            iconColor: .lighter,
            actionButton: PBButton(variant: .link, icon: PBIcon.fontAwesome(.plus)) {}
          ) {
            Text("People").pbFont(.body)
            Spacer()
          } content: {
            peopleContent
          }
        }
      }
      Spacer()
    }
    .colorScheme(.light)
  }
}

extension LayoutView {
  static let rooms = ["S.H.I.E.L.D", "System Operations", "Birds of Prey", "UX Nitro", "Incredibles", "Home Tour"]

  enum Layout: CaseIterable {
    case classic, cozy

    var title: String {
      switch self {
      case .classic: return "Classic"
      case .cozy: return "Cozy"
      }
    }

    var index: Int {
      switch self {
      case .classic: return 0
      case .cozy: return 1
      }
    }
  }

  var roomIconSize: PBIcon.IconSize {
    switch Layout.allCases[selectedLayout] {
    case .classic: return .small
    case .cozy: return .xSmall
    }
  }

  var roomContent: some View {
    VStack(spacing: Spacing.xSmall) {
      ForEach(LayoutView.rooms, id: \.self) { room in
        HStack {
          PBIconCircle(FontAwesome.lock, size: roomIconSize, color: .blue)
          Text(room)
          Spacer()
          PBBadge(text: "1", rounded: true, variant: .chat)
        }
      }
    }
  }

  func multipleUserView(users: [PBUser]) -> some View {
    HStack(spacing: Spacing.small) {
      PBMultipleUsersStacked(users: Mocks.multipleUsers, size: .small)
      let userNames = users.map { $0.name }.prefix(2).joined(separator: ", ")
      Text(userNames).pbFont(.title4)
    }
    .padding(.bottom, Spacing.xxSmall)
    .padding(.trailing, Spacing.xxSmall)
  }

  func singleUserView(user: PBUser) -> some View {
    PBUser(
      name: user.name,
      image: user.image ?? Image("ana"),
      orientation: .horizontal,
      size: .small,
      title: user.title,
      status: user.status,
      displayAvatar: true
    )
  }

  var peopleContent: some View {
    VStack(spacing: Spacing.xSmall) {
      ForEach(users.indices, id: \.self) { index in
        let users = users[index]
        let user = users[0]
        HStack {
          if users.count > 1 {
            multipleUserView(users: users)
          } else {
            singleUserView(user: user)
          }
          Spacer()
          PBBadge(text: "1", rounded: true, variant: .chat)
        }
      }
    }
  }
}

#Preview {
  registerFonts()
  return LayoutView().padding()
}
