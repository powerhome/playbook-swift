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
    @FocusState var isFocused1
    @FocusState var isFocused2
    
    public var body: some View {
        PBDocStack(title: "Typeahead") {
            PBDoc(title: "Default", spacing: Spacing.small) { colors }
            PBDoc(title: "With Pills", spacing: Spacing.small) { users }
            //      PBDoc(title: "Debounce", spacing: Spacing.small) { debounce }
        }
        .onTapGesture {
            isFocused1 = false
            isFocused2 = false
        }
        .popoverHandler(id: 0)
        .popoverHandler(id: 1)
    }
}

extension TypeaheadCatalog {
    var colors: some View {
        PBTypeahead(
            id: 0,
            title: "Colors",
            searchText: $searchTextColors,
            selection: .single,
            options: assetsColors,
            isFocused: $isFocused1
        ) {_ in }
    }
    
    var users: some View {
        PBTypeahead(
            id: 1,
            title: "Users",
            placeholder: "type the name of a user",
            searchText: $searchTextUsers,
            selection: .multiple(variant: .pill),
            options: assetsUsers,
            isFocused: $isFocused2
        ) {_ in }
    }
    
    //  var debounce: some View {
    //    VStack(spacing: Spacing.small) {
    //      PBTypeahead(
    //        id: 2,
    //        title: "Debounce, 2 characters, 1 second",
    //        searchText: $searchTextDebounce,
    //        selection: .single,
    //        options: assetsColors,
    //        debounce: (1, 2)
    //      ) {_ in }
    //
    //      PBTypeahead(
    //        id: 3,
    //        title: "Debounce, 2 characters, 0 second",
    //        searchText: $searchTextDebounce2,
    //        selection: .single,
    //        options: assetsColors,
    //        debounce: (0, 2)
    //      ) {_ in }
    //    }
    //  }
}
