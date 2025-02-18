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
  @State private var users = Mocks.multipleUsersGroup
  @State var selectedLayout: Int = Layout.classic.layoutIndex
  @State private var hoveringItem: String?
  @State private var hoveringIndex: Int?
  @State private var isHoveringRoom: Bool = false
  @State private var isHoveringPeople: Bool = false
  @State private var rooms = ["S.H.I.E.L.D", "System Operations", "Birds of Prey", "UX Nitro", "Incredibles", "Home Tour"]

  let action: (() -> Void)?

  public init(
    action: (() -> Void)? = nil
  ) {
    self.action = action
  }

  var body: some View {
    VStack(alignment: .leading, spacing: Spacing.none) {
      PBNav(selected: $selectedLayout, variant: .subtle, orientation: .horizontal, borders: false, highlight: false) {
        PBNavItem(Layout.classic.title)
        PBNavItem(Layout.comfortable.title)
      }

      ScrollView {
        VStack(spacing: Spacing.xSmall) {
          PBCollapsible(
            isCollapsed: true,
            iconSize: .small,
            iconColor: .lighter,
            actionButton: PBButton(variant: .link, size: .small, icon: PBIcon.fontAwesome(.plus, size: .xSmall)) {}
          ) {
            Text("Rooms")
              .pbFont(.caption)

            Spacer()
          } content: {
            roomContent
          }
          .padding(.horizontal, Spacing.small)

          PBCollapsible(
            isCollapsed: false,
            iconSize: .small,
            iconColor: .lighter,
            actionButton: PBButton(variant: .link, icon: PBIcon.fontAwesome(.plus, size: .xSmall)) {}
          ) {
            Text("People")
              .pbFont(.caption)

            Spacer()
          } content: {
            peopleContent
          }
          .padding(.horizontal, Spacing.small)
        }
      }
      Spacer()
    }
    .background(Color.background(.default))
  }
}

extension LayoutView {

  enum Layout: CaseIterable {
    case classic, comfortable

    var title: String {
      switch self {
      case .classic: return "Classic"
      case .comfortable: return "Comfortable"
      }
    }

    var layoutIndex: Int {
      switch self {
      case .classic: return 0
      case .comfortable: return 1
      }
    }
  }

  var roomIconSize: PBIcon.IconSize {
    switch Layout.allCases[selectedLayout] {
    case .classic: return .x1
    case .comfortable: return .xSmall
    }
  }

  var roomContent: some View {
    VStack(spacing: Spacing.none) {
      ForEach(rooms, id: \.self) { room in
        roomRow(room: room, isHovering: hoveringItem == room ? true : false)
          .background(hoveringItem == room ? Color.active : .clear)
          .draggable(room)
          .dropDestination(for: String.self) { droppedTabs, location in
            guard let droppedTab = droppedTabs.first,
                  let sourceIndex = rooms.firstIndex(of: droppedTab),
                  let targetIndex = rooms.firstIndex(of: room) else { return false }

            rooms.move(from: sourceIndex, to: targetIndex)
            return true
          }
          .onHover { isHovering in
            self.hoveringItem = room
            isHoveringRoom = isHovering
            #if os(macOS)
            if isHovering {
              NSCursor.pointingHand.set()
            } else {
              NSCursor.arrow.set()
            }
            #endif
          }
      }
    }
  }

  func roomRow(room: String, isHovering: Bool) -> some View {
    HStack {
        PBIconCircle(FontAwesome.lock, size: roomIconSize, color: .blue)
        .padding(.trailing, selectedLayout == 0 ? Spacing.xxSmall : Spacing.xxSmall)
        Text(room).pbFont(.body)
        Spacer()

        PBBadge(text: "1", rounded: true, variant: .chat)
       #if os(macOS)
       closeButton
         .opacity(isHovering ? 1 : 0)
         .padding(.trailing, isHovering ?  Spacing.small : 0)
       #endif
    }
    .frame(height: selectedLayout == 0 ? 50 : 38)
  }

  var peopleContent: some View {
    VStack(spacing: Spacing.none) {
      ForEach(users.indices, id: \.self) { index in
        let users = users[index]
        peopleRow(users: users, isHovering: hoveringIndex == index ? true : false)
          .background(hoveringIndex == index ? Color.active : .clear)
          .onHover { isHovering in
            self.hoveringIndex = index
            isHoveringPeople = isHovering
            #if os(macOS)
            if isHovering {
              NSCursor.pointingHand.set()
            } else {
              NSCursor.arrow.set()
            }
            #endif
          }
      }
    }
  }

  func peopleRow(users: [PBUser], isHovering: Bool) -> some View {
    HStack {
      if users.count > 1 {
        multipleUserView(users: users)
      } else {
        singleUserView(user: users[0])
      }
      Spacer()
      PBBadge(text: "1", rounded: true, variant: .chat)
      #if os(macOS)
      closeButton
        .padding(.trailing, isHovering ?  Spacing.small : 0)
        .opacity(isHovering ? 1 : 0)
      #endif
    }
    .frame(height: selectedLayout == 0 ? 50 : 35)
  }

  func multipleUserView(users: [PBUser]) -> some View {
    HStack {
      switch Layout.allCases[selectedLayout] {
      case .classic, .comfortable:
        PBMultipleUsersStacked(users: Mocks.multipleUsers, size: .default)
          .padding(.leading, users.count >= 2 ? 7 : 0)
          .padding(.trailing, selectedLayout == 0 ? Spacing.xSmall+5 : Spacing.xxSmall)
      }
      let userNames = users.map { $0.name }.prefix(2).joined(separator: ", ")
      Text(userNames).pbFont(.title4)
    }
  }

  @ViewBuilder
  func singleUserView(user: PBUser) -> some View {
    switch Layout.allCases[selectedLayout] {
    case .classic:
      PBUser(
        name: user.name,
        image: user.image ?? Image("ana"),
        orientation: .horizontal,
        size: .small,
        territory: "PHL",
        title: user.title,
        status: user.status,
        displayAvatar: true
      )
      .padding(.trailing, selectedLayout == 0 ? Spacing.xSmall+5 : Spacing.xxSmall)
    case .comfortable:
      HStack {
        PBAvatar(image: Image("Ana"), name: "Ana Black", size: .xSmall, status: .online, statusSize: .small)
          .padding(.trailing, selectedLayout == 0 ? Spacing.xSmall+5 : Spacing.xxSmall)
          .padding(.leading, Spacing.xxSmall)
        Text(user.name).pbFont(.body)
      }
    }
  }

  var closeButton: some View {
    Button {
    action?()
    } label: {
      PBIcon(FontAwesome.xmark)
        .foregroundStyle(Color.text(.light))
    }
    .buttonStyle(.plain)
  }
}

#Preview {
  registerFonts()
  return LayoutView().padding()
}
