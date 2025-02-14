//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ConvoListPrototype.swift
//

import SwiftUI
import Playbook

struct ConvoListPrototype: View {
  @State var selectedLayout: Int = 0
  @State var selectedConvo: Int = 0
  @State var isCollapsed: Bool = false

  var body: some View {

    VStack(alignment: .leading) {
      PBCard(border: false, borderRadius: BorderRadius.large, padding: Spacing.small, shadow: .deep) {
        PBNav(selected: $selectedLayout, variant: .subtle, orientation: .horizontal, borders: false, highlight: false) {
          PBNavItem("Comfortable")

          PBNavItem("Classic")
        }
        ScrollView {
          CollapsibleDoc(
            iconSize: .small,
            iconColor: .lighter,
            text: "Rooms",
            category: .rooms,
            selectedLayout: $selectedLayout
          )
          CollapsibleDoc(
            iconSize: .small,
            iconColor: .lighter,
            text: "People",
            category: .people,
            selectedLayout: $selectedLayout
          )
        }
        .scrollIndicators(.hidden)
      }
    }
    Spacer()
  }
}

struct CollapsibleDoc: View {
  @State var users = ["andrew", "ana", "patric", "luccile"]
  @State var rooms = [
    "S.H.I.E.L.D",
    "System Operations",
    "Ninja Announcements",
    "Avengers",
    "Birds of Prey",
    "UX Nitro",
    "Incredibles",
    "Home Tour"
  ]
  @State private var colors: [Color] = [.blue, .green, .yellow, .orange, .red]
  @State private var isCollapsed = true
  @Binding var selectedLayout: Int
  let iconSize: PBIcon.IconSize
  let iconColor: CollapsibleIconColor
  let text: String
  var category: Category
  var bubbleCount: PBMultipleUsers.BubbleCount

  public init(
    iconSize: PBIcon.IconSize = .small,
    iconColor: CollapsibleIconColor = .default,
    text: String,
    category: Category = .rooms,
    bubbleCount: PBMultipleUsers.BubbleCount = .four,
    selectedLayout: Binding<Int> = .constant(0)

  ) {
    self.iconSize = iconSize
    self.iconColor = iconColor
    self.text = text
    self.category = category
    self.bubbleCount = bubbleCount
    self._selectedLayout = selectedLayout
  }

  var body: some View {
    PBCollapsible(isCollapsed: $isCollapsed, iconSize: iconSize, iconColor: iconColor) {
      Text(text).pbFont(.body)
    } content: {
      if category == .rooms {
        roomContent
      } else if category == .people {
        peopleContent
      }
    }
    .frame(alignment: .leading)
  }
}

extension CollapsibleDoc {
  enum Category {
    case rooms, people
  }

  var roomContent: some View {
    VStack(spacing: Spacing.small) {
      ForEach(rooms, id: \.self) { room in
        PBNavItem {
          if selectedLayout == 0 {
            HStack {
              PBIconCircle(
                FontAwesome.lock,
                size: .custom(16),
                color: .blue
              )
              Text(room)
              Spacer()
              PBBadge(text: "1", rounded: true, variant: .chat)
            }
            .padding(.leading, -Spacing.small)
            .padding(.trailing, -Spacing.small)
          }
        }
        PBNavItem {
          if selectedLayout == 1 {
            HStack {
              PBIconCircle(FontAwesome.lock, size: .custom(16), color: .blue)
              Text(room)
              Spacer()
              PBBadge(text: "3", rounded: true, variant: .chat)
            }
          }
        }
      }
      .padding(.vertical, -25)
    }
    .padding(.leading, 0)
    .padding(.bottom, selectedLayout == 1 ? 10 : 1)
    .padding(.top, selectedLayout == 1 ? -20 : -5)
  }
  var peopleContent: some View {
    ScrollView {
      ForEach(users, id: \.self) { user in
        PBNavItem {
          HStack {
            PBUser(
              name: "\(user)",
              image: Image("\(user)"),
              orientation: .horizontal,
              size: .small,
              title: "User Experience Engineer",
              status: .away,
              displayAvatar: true
            )
            .padding(.vertical, -Spacing.xSmall)
            Spacer()
            PBBadge(text: "1", rounded: true, variant: .chat)
          }
        }
      }

      PBNavItem {
        VStack(spacing: Spacing.medium) {
          HStack(spacing: Spacing.small) {
            PBMultipleUsersStacked(users: Mocks.multipleUsers, size: .small)
            VStack {
              PBUser(
                name: "Anna Black",
                size: .small,
                territory: "PHL",
                title: "Nitro Developer",
                displayAvatar: false
              )
            }
            Spacer()
            PBBadge(text: "1", rounded: true, variant: .chat)
          }

          HStack(spacing: Spacing.small) {
            PBMultipleUsersStacked(users: Mocks.multipleUsers, size: .small)
            VStack {
              PBUser(
                name: "Anna ",
                size: .small,
                territory: "PHL",
                title: "Nitro Developer",
                displayAvatar: false
              )
            }
            Spacer()
            PBBadge(text: "1", rounded: true, variant: .chat)
          }
        }
      }
    }
    .padding(.leading, -15)
  }
}

enum Mocks {
  static let andrew = PBUser(
    name: "Andrew Black",
    image: Image("andrew"),
    size: .small,
    title: "Senior User Experience Engineer"
  )
  static let ana = PBUser(
    name: "Anna Black",
    image: Image("Anna"),
    size: .small,
    title: "Senior User Experience Engineer"
  )
  static let patric = PBUser(
    name: "Pat Black",
    image: Image("Pat"),
    size: .small,
    title: "Senior User Experience Engineer"
  )
  static let luccile = PBUser(
    name: "Luccile Black",
    image: Image("Luccile"),
    size: .small,
    title: "Senior User Experience Engineer"
  )
  static let oneUser = [andrew]
  static let twoUsers = [andrew, ana]
  static let threeUsers = [andrew, ana, patric]
  static let multipleUsers = [andrew, ana, patric, luccile]

  static let avatarXSmall = PBAvatar(image: Image("andrew"), size: .xSmall)
  static let avatarXSmallStatus = PBAvatar(image: Image("andrew"), size: .xSmall, status: .online)
  static let userName = "Andrew Black"
  static let message: AttributedString = "How can we assist you today?"
  static let timestamp =  PBTimestamp(Date(), showDate: false)
  static let picAnna = PBAvatar(image: Image("Anna"), size: .xSmall, status: .online)
  static let picPatric = PBAvatar(image: Image("Pat"), size: .xSmall)
  static let picLuccile = PBAvatar(image: Image("Lu"), size: .xSmall)
  //    static let assetsColors: [PBTypeahead.Option] = [
  //        .init(id: "1", text: "Orange", customView: nil),
  //        .init(id: "2", text: "Red", customView: nil),
  //        .init(id: "3", text: "Blue", customView: nil),
  //        .init(id: "4", text: "Pink", customView: nil),
  //        .init(id: "5", text: "Magenta", customView: nil)
  //    ]
  //    static let assetesMultipleUsers: [PBTypeahead.Option] = [
  //        .init(id: "1", text: andrew.name, customView: { AnyView(andrew) }),
  //        .init(id: "2", text: ana.name, customView: { AnyView(ana) }),
  //        .init(id: "3", text: patric.name, customView: { AnyView(patric) }),
  //        .init(id: "4", text: luccile.name, customView: { AnyView(luccile) })
  //    ]

  //    static let assetsSectionUsers: [PBTypeahead.OptionType] = [
  //        .section("section 1"),
  //        .item(.init(id: "1", text: andrew.name, customView: { AnyView(andrew) })),
  //        .item(.init(id: "2", text: ana.name, customView: { AnyView(ana) })),
  //        //        .item(.init(id: "3", text: patric.name, customView: { AnyView(patric) })),
  //        //        .item(.init(id: "4", text: luccile.name, customView: { AnyView(luccile) })),
  //        //        .button(PBButton(variant: .link, title: "view more")),
  //            .section("section 2"),
  //        .item(.init(id: "5", text: andrew.name, customView: { AnyView(andrew) })),
  //        //        .item(.init(id: "6", text: ana.name, customView: { AnyView(ana) })),
  //        //        .item(.init(id: "7", text: patric.name, customView: { AnyView(patric) })),
  //            .item(.init(id: "8", text: luccile.name, customView: { AnyView(luccile) }))
  //        //        .button(PBButton(variant: .primary, title: "view more"))
  //    ]

  static let cities: [String] = [
    "Philadelphia",
    "New York",
    "Chicago",
    "Los Angeles",
    "San Francisco",
    "Boston",
    "Miami",
    "Seattle",
    "Dallas"
  ]
}

extension Mocks: Identifiable, Hashable {
  var id: ObjectIdentifier {
    self.id
  }
}

#Preview {
  ConvoListPrototype()
}
