//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  NavCatalog.swift
//

import SwiftUI
import Playbook

enum NavContent {
  case vertical, horizontal, custom
}

public struct NavCatalog: View {
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
  @State private var selectedHFullDefault: Int = 1
  @State private var selectedHSubtle: Int = 1
  @State private var selectedHSubtleNoHighlight: Int = 1
  @State private var selectedHBold: Int = 1
  @State private var selectedCustom: Int = 1
  @State private var navContent: NavContent = .vertical
  
  public var body: some View {
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
        PBNavItem("Messages", icon: .pbIcon(.fontAwesome(.messages)))
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
          icon: .custom(AnyView(Image(systemName: "bubble.left.and.bubble.right")))
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
        PBNavItem("Messages", icon: .pbIcon(.fontAwesome(.messages)))
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

    return PBDocStack(title: "Nav") {
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
    
    var fullWidthNav: some View {
      return PBDoc(title: "Full Width Horizontal Nav") {
          PBNav(
            selected: $selectedHFullDefault,
            variant: .normal,
            orientation: .horizontal
            
          ) {
            PBNavItem(
              "Photos", 
              isFullWidth: true
            )
            PBNavItem(
              "Music", 
              isFullWidth: true
            )
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

    return PBDocStack(title: "Nav") {
      navDefault
      fullWidthNav
      subtle
      subtleNoHighlights
      boldVariant
    }
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
            image: Image("Anna"),
            size: .small,
            title: "PHL • Remodeling Consultant"
          )
        }
        PBNavItem {
          PBUser(
            name: "Julie",
            image: Image("Julie"),
            size: .small,
            title: "PHL • Sales Agent"
          )
        }
        PBNavItem {
          PBUser(
            name: "Denis Wilks",
            image: Image("andrew"),
            size: .small,
            title: "PHL • Remodeling Consultant"
          )
        }
      }
    }

    return PBDocStack(title: "Nav") {
      navUsers
    }
  }
}
