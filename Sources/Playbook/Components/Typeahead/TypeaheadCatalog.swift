//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  TypeaheadCatalog.swift
//

import SwiftUI

public struct TypeaheadCatalog: View {
  @State private var assetsColors = Mocks.assetsColors
  @State private var assetsUsers = Mocks.multipleUsersDictionary
  @State private var searchTextUsers: String = ""
  @State private var searchTextColors: String = ""
  @State private var searchTextDebounce: String = ""
  @State private var searchTextDebounce2: String = ""
  @State private var didTapOutside: Bool? = false
  var popoverManager = PopoverManager()
  
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default", spacing: Spacing.small) { colors }
        PBDoc(title: "With Pills", spacing: Spacing.small) { users }
        PBDoc(title: "Debounce", spacing: Spacing.small) { debounce }
      }
      .padding(Spacing.medium)
      .withPopoverHandling(popoverManager)
    }
    
    .background(Color.background(.light))
    .navigationTitle("Typeahead")
    .scrollDismissesKeyboard(.immediately)
  }
}

extension TypeaheadCatalog {
  var colors: some View {
    PBTypeahead(
      title: "Colors",
      searchText: $searchTextColors,
      selection: .single,
      options: assetsColors,
      popoverManager: popoverManager
    ) { options in
      print("Selected options \(options)")
    }
  }
  
  var users: some View {
    PBTypeahead(
      title: "Users",
      placeholder: "type the name of a user",
      searchText: $searchTextUsers,
      selection: .multiple(variant: .pill),
      options: assetsUsers,
      popoverManager: popoverManager
    ) { options in
      print("Selected options \(options)")
    }
  }
  
  var debounce: some View {
    VStack(spacing: Spacing.small) {
      PBTypeahead(
        title: "Debounce, 2 characters, 1 second",
        searchText: $searchTextDebounce,
        selection: .single,
        options: assetsColors,
        debounce: (1, 2),
        popoverManager: popoverManager
      ) { options in
        print("Selected options \(options)")
      }
      
      PBTypeahead(
        title: "Debounce, 2 characters, 0 second",
        searchText: $searchTextDebounce2,
        selection: .single,
        options: assetsColors,
        debounce: (0, 2),
        popoverManager: popoverManager
      ) { options in
        print("Selected options \(options)")
      }
    }
  }
}
