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
        Text("Orizontal").tag(NavContent.horizontal)
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
    let navDefault = Section("Default") {
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

    let defaultWithIcons = Section("With Icons") {
      PBNav(
        selected: $selectedVIcon,
        variant: .normal,
        orientation: .vertical,
        title: "Browse"
      ) {
        PBNavItem("News Feed", icon: .pbIcon(.fontAwesome(.newspaper)))
        PBNavItem("Messages", icon: .pbIcon(.fontAwesome(.snapchatSquare)))
        PBNavItem("Events", icon: .pbIcon(.fontAwesome(.calendarCheck)))
        PBNavItem("Friends", icon: .pbIcon(.fontAwesome(.peopleCarry)))
        PBNavItem("Groups", icon: .pbIcon(.fontAwesome(.campground)))
      }
    }

    let defaultWithCustomIcons = Section("With Custom Icon") {
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
          icon: .custom(AnyView(Image(systemName: "message")))
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

    let defaultWithNoHighlights = Section("No Highlight") {
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

    let defaultWithNoBorders = Section("No borders") {
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

    let subtle = Section("Subtle Variant") {
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

    let subtleWithIcons = Section("Subtle With Icons") {
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

    let subtleWithNoHighlights = Section("Subtle No Highlight") {
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

    let boldVariant = Section("Bold Variant") {
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

    return List {
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
  }

  var horizontalListView: some View {
    let navDefault = Section("Default") {
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

    let subtle = Section("Subtle Horizontal Nav") {
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

    let subtleNoHighlights = Section("Subtle Horizontal No Hilight") {
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

    let boldVariant = Section("Bold Horizontal Nav") {
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

    return List {
      navDefault
      subtle
      subtleNoHighlights
      boldVariant
    }
  }

  var customListView: some View {
    let navUsers = Section("Block") {
      PBNav(
        selected: $selectedCustom,
        variant: .normal,
        orientation: .vertical,
        title: "Users"
      ) {
        PBNavItem {
          PBUser(name: "Anna Black", image: Image("Anna", bundle: .module), size: .small, title: "PHL • Remodeling Consultant")
        }
        PBNavItem {
          PBUser(name: "Julie", image: Image("Julie", bundle: .module), size: .small, title: "PHL • Sales Agent")
        }
        PBNavItem {
          PBUser(name: "Denis Wilks", image: Image("andrew", bundle: .module), size: .small, title: "PHL • Remodeling Consultant")
        }
      }
    }
    return List {
      navUsers
    }
  }
}
