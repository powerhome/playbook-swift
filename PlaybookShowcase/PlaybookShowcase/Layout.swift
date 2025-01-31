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

struct CollapsibleDoc: View {
    let users = ["Andrew", "Anna", "Pat" ,"Luccile", "Leo", "Ronnie", "Julie" ]
    let rooms = ["S.H.I.E.L.D", "System Operations", "Ninja Announcements" ,"Birds of Prey", "UX Nitro", "Incredibles", "Home Tour"]
    let colors: [Color] = [.blue, .green, .yellow, .orange, .red]
    @Binding var selectedLayout: Int
    @State private var isCollapsed = true
    let iconSize: PBIcon.IconSize
    let iconColor: CollapsibleIconColor
    let text: String
    var category: Category
    let size: PBMultipleUsers.BubbleSize = .small
    var multipleUsers = ["Andrew", "Anna", "Pat" ,"Luccile", "Leo", "Ronnie", "Julie" ]

    public init(
        iconSize: PBIcon.IconSize = .small,
        iconColor: CollapsibleIconColor = .default,
        text: String,
        category: Category = .rooms,
        selectedLayout: Binding<Int> = .constant(0)
    ) {
        self.iconSize = iconSize
        self.iconColor = iconColor
        self.text = text
        self.category = category
        self._selectedLayout = selectedLayout
    }

    var body: some View {
        PBCollapsible(isCollapsed: $isCollapsed, iconSize: iconSize, iconColor: iconColor, actionButton: PBButton(variant: .link, icon: PBIcon.fontAwesome(.plus))) {
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
                            PBIconCircle(FontAwesome.lock, size: .large, color: .blue)
                            Text(room)
                            Spacer()
                            PBBadge(text: "1", rounded: true, variant: .chat)
                        }
                    }
                }

                PBNavItem {
                    if selectedLayout == 1 {
                        HStack {
                            PBIconCircle(FontAwesome.lock, size: .large, color: .blue)
                            Text(room)
                            Spacer()
                            PBBadge(text: "3", rounded: true, variant: .chat)
                        }
                    }
                }
            }
            .padding(.vertical, -20)
        }
        .padding(.leading, -16)
        .padding(.bottom, selectedLayout == 1 ? 10 : 1)
        .padding(.top, selectedLayout == 1 ? -20 : -12)
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
                                name: "Anna ",                                size: .small,
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

struct ContentView: View {
    @State var users = ["Andrew", "Anna", "Pat" ,"Luccile" ]
    @State var selectedLayout: Int = 0
    @State var selectedConvo: Int = 0
    @State var isCollapsed: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.none) {
//            PBCard(border: false, borderRadius: BorderRadius.large, padding: Spacing.small, shadow: Shadow.deep) {
                PBNav(selected: $selectedLayout, variant: .subtle, orientation: .horizontal, borders: false, highlight: false) {
                    PBNavItem("Comfortable")

                    PBNavItem("Classic")
                }
                ScrollView {
                    CollapsibleDoc(iconSize: .small, iconColor: .lighter, text: "Rooms", category: .rooms, selectedLayout: $selectedLayout)
                        .padding(.leading)
                    CollapsibleDoc(iconSize: .small, iconColor: .lighter, text: "People", category: .people, selectedLayout: $selectedLayout)
                        .padding(.leading)
                }
//            }
             Spacer()
        }
        .colorScheme(.light)
    }
}

#Preview {
    ContentView()
}
