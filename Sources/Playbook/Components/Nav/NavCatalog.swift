//
//  NavCatalog.swift
//
//
//  Created by Isis Silva on 12/07/23.
//

import SwiftUI

enum NavContent {
  case vertical, horizontal, custom
}

struct NavCatalog: View {
  @State private var selectedVDefault: Int = 1
  @State private var selectedVIcon: Int = 1
  @State private var selectedVCustomIcon: Int = 1
  @State private var selectedVNoHighlight: Int = 1
  @State private var selectedNoBorders: Int = 1
  @State private var selectedVSubtle: Int = 1
  @State private var selectedVSubtleWithIcon: Int = 1
  @State private var selectedVSubtleNoHighlight: Int = 1
  @State private var selectedVBold: Int = 1
  @State private var selectedHDefault: Int = 1
  @State private var selectedHSubtle: Int = 1
  @State private var selectedHSubtleNoHighlight: Int = 1
  @State private var selectedHBold: Int = 1
  @State private var selectedCustom: Int = 1
  @State private var navContent: NavContent = .vertical
  
  var body: some View {
    VStack {
      Picker("Select", selection: $navContent) {
        Text("Vertical").tag(NavContent.vertical)
        Text("Horizontal").tag(NavContent.horizontal)
        Text("Custom").tag(NavContent.custom)
      }
      .pickerStyle(.segmented)
      .padding()

      switch navContent {
      case .vertical: verticalListView
      case .horizontal: horizontalListView
      case .custom: customListView
      }
    }
  }

  var verticalListView: some View {
    let navDefault = PBDoc(title: "Default") {
      PBNav(
        selected: $selectedVDefault,
        variant: .normal,
        orientation: .vertical,
        title: "Menu"
      ) {
        PBNavItem("Photos")
        PBNavItem("Music")
        PBNavItem("Video")
        PBNavItem("Files")
      }
    }

    let defaultWithIcons = PBDoc(title: "With Icons") {
      PBNav(
        selected: $selectedVIcon,
        variant: .normal,
        orientation: .vertical,
        title: "Browse"
      ) {
        PBNavItem("News Feed", icon: .pbIcon(.fontAwesome(.newspaper)), accessory: .chevronDown)
        PBNavItem("Messages", icon: .pbIcon(.fontAwesome(.snapchatSquare)))
        PBNavItem("Events", icon: .pbIcon(.fontAwesome(.calendarCheck)))
        PBNavItem("Friends", icon: .pbIcon(.fontAwesome(.peopleCarry)))
        PBNavItem("Groups", icon: .pbIcon(.fontAwesome(.campground)))
      }
    }

    let defaultWithCustomIcons = PBDoc(title: "With Custom Icon") {
      PBNav(
        selected: $selectedVCustomIcon,
        variant: .normal,
        orientation: .vertical,
        title: "Browse"
      ) {
        PBNavItem(
          "News Feed",
          icon: .custom(AnyView(Image(systemName: "newspaper")))
        )
        PBNavItem(
          "Messages",
          icon: .image(PBImage(image: Image("andrew", bundle: .module)))
        )
        PBNavItem(
          "Events",
          icon: .custom(AnyView(Image(systemName: "calendar")))
        )
        PBNavItem(
          "Friends",
          icon: .custom(AnyView(Text("👯‍♂️")))
        )
        PBNavItem(
          "Groups",
          icon: .custom(AnyView(Text("👨‍👩‍👦‍👦")))
        )
      }
    }

    let defaultWithNoHighlights = PBDoc(title: "No Highlight") {
      PBNav(
        selected: $selectedVNoHighlight,
        variant: .normal,
        orientation: .vertical,
        highlight: false
      ) {
        PBNavItem("Photos")
        PBNavItem("Music")
        PBNavItem("Video")
        PBNavItem("Files")
      }
    }

    let defaultWithNoBorders = PBDoc(title: "No borders") {
      PBNav(
        selected: $selectedNoBorders,
        variant: .normal,
        orientation: .vertical,
        borders: false
      ) {
        PBNavItem("Photos")
        PBNavItem("Music")
        PBNavItem("Video")
        PBNavItem("Files")
      }
    }

    let subtle = PBDoc(title: "Subtle Variant") {
      PBNav(
        selected: $selectedVSubtle,
        variant: .subtle,
        orientation: .vertical,
        borders: false
      ) {
        PBNavItem("Photos")
        PBNavItem("Music")
        PBNavItem("Video")
        PBNavItem("Files")
      }
    }

    let subtleWithIcons = PBDoc(title: "Subtle With Icons") {
      PBNav(
        selected: $selectedVSubtleWithIcon,
        variant: .subtle,
        orientation: .vertical
      ) {
        PBNavItem("News Feed", icon: .pbIcon(.fontAwesome(.newspaper)))
        PBNavItem("Messages", icon: .pbIcon(.fontAwesome(.snapchatSquare)))
        PBNavItem("Events", icon: .pbIcon(.fontAwesome(.calendarCheck)))
        PBNavItem("Friends", icon: .pbIcon(.fontAwesome(.peopleCarry)))
        PBNavItem("Groups", icon: .pbIcon(.fontAwesome(.campground)))
      }
    }

    let subtleWithNoHighlights = PBDoc(title: "Subtle No Highlight") {
      PBNav(
        selected: $selectedVSubtleNoHighlight,
        variant: .subtle,
        orientation: .vertical,
        borders: false,
        highlight: false
      ) {
        PBNavItem("Photos")
        PBNavItem("Music")
        PBNavItem("Video")
        PBNavItem("Files")
      }
    }

    let boldVariant = PBDoc(title: "Bold Variant") {
      PBNav(
        selected: $selectedVBold,
        variant: .bold,
        orientation: .vertical,
        borders: false
      ) {
        PBNavItem("Photos")
        PBNavItem("Music")
        PBNavItem("Video")
        PBNavItem("Files")
      }
    }

    return ScrollView {
      VStack(spacing: Spacing.medium) {
        navDefault
        defaultWithIcons
        defaultWithCustomIcons
        defaultWithNoHighlights
        defaultWithNoBorders
        subtle
        subtleWithIcons
        subtleWithNoHighlights
        boldVariant
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Nav")
  }

  var horizontalListView: some View {
    let navDefault = PBDoc(title: "Default") {
      ScrollView(.horizontal, showsIndicators: false) {
        PBNav(
          selected: $selectedHDefault,
          variant: .normal,
          orientation: .horizontal
        ) {
          PBNavItem("Photos")
          PBNavItem("Music")
          PBNavItem("Video")
          PBNavItem("Files")
        }
      }
    }

    let subtle = PBDoc(title: "Subtle Horizontal Nav") {
      PBNav(
        selected: $selectedHSubtle,
        variant: .subtle,
        orientation: .horizontal,
        borders: false
      ) {
        PBNavItem("Photos")
        PBNavItem("Music")
        PBNavItem("Video")
        PBNavItem("Files")
      }
    }

    let subtleNoHighlights = PBDoc(title: "Subtle Horizontal No Hilight") {
      PBNav(
        selected: $selectedHSubtleNoHighlight,
        variant: .subtle,
        orientation: .horizontal,
        borders: false,
        highlight: false
      ) {
        PBNavItem("Photos")
        PBNavItem("Music")
        PBNavItem("Video")
        PBNavItem("Files")
      }
    }

    let boldVariant = PBDoc(title: "Bold Horizontal Nav") {
      PBNav(
        selected: $selectedHBold,
        variant: .bold,
        orientation: .horizontal,
        borders: false
      ) {
        PBNavItem("Photos")
        PBNavItem("Music")
        PBNavItem("Video")
        PBNavItem("Files")
      }
    }

    return ScrollView {
      VStack(spacing: Spacing.medium) {
        navDefault
        subtle
        subtleNoHighlights
        boldVariant
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Tab Bar")
  }

  var customListView: some View {
    let navUsers = PBDoc(title: "Block") {
      PBNav(
        selected: $selectedCustom,
        variant: .normal,
        orientation: .vertical,
        title: "Users"
      ) {
        PBNavItem {
          PBUser(
            name: "Anna Black",
            image: Image("Anna", bundle: .module),
            size: .small,
            title: "PHL • Remodeling Consultant"
          )
        }
        PBNavItem {
          PBUser(
            name: "Julie",
            image: Image("Julie", bundle: .module),
            size: .small,
            title: "PHL • Sales Agent"
          )
        }
        PBNavItem {
          PBUser(
            name: "Denis Wilks",
            image: Image("andrew", bundle: .module),
            size: .small,
            title: "PHL • Remodeling Consultant"
          )
        }
      }
    }

    return ScrollView {
      VStack(spacing: Spacing.medium) {
        navUsers
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Nav")
  }
}
