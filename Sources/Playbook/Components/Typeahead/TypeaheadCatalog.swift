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
    @State private var selectedUsers: [(String, (String, (() -> PBUser?)?)?)] = []
    @State private var searchTextUsers: String = ""
    @State private var searchTextColors: String = ""
    @State private var searchText: String = ""
    @State private var searchTextDebounce: String = ""
    @State private var didTapOutside: Bool? = false
    @State private var isPresented1: Bool = false
    @State private var presentDialog: Bool = false
    @State private var isLoading: Bool = false
    @State private var assetsUser = Mocks.multipleUsersDictionary
    @FocusState var isFocused1
    @FocusState var isFocused2

    var popoverManager = PopoverManager()
    
    public var body: some View {
        PBDocStack(title: "Typeahead") {
            PBDoc(title: "Default", spacing: Spacing.small) { colors }
            PBDoc(title: "With Pills", spacing: Spacing.small) { users }
            #if os(macOS)
            PBDoc(title: "Dialog") { dialog }
            #endif
        }
        .onTapGesture {
            isFocused1 = false
            isFocused2 = false
        }
        .popoverHandler(id: 1)
        .popoverHandler(id: 2)
    }
}

extension TypeaheadCatalog {
    var colors: some View {
        PBTypeahead(
            id: 1,
            title: "Colors",
            searchText: $searchTextColors,
            options: $assetsColors, 
            selection: .single,
            isFocused: $isFocused1
        ) { _ in }
    }
    
    var users: some View {
        PBTypeahead(
            id: 2,
            title: "Users",
            placeholder: "type the name of a user",
            searchText: $searchTextUsers,
            options: $assetsUsers, 
            selection: .multiple(variant: .pill),
            isFocused: $isFocused2
        ) { selected in
            selectedUsers = selected
            print(selected)
        }
        
    }
    
    func closeToast() {
        presentDialog = false
    }

    var dialog: some View {
        PBButton(title: "Simple") {
            DialogCatalog.disableAnimation()
            presentDialog.toggle()
        }
        .presentationMode(isPresented: $presentDialog) {
            DialogView(isPresented: $presentDialog)
                .popoverHandler(id: 4)
                #if os(macOS)
                .frame(minWidth: 500, minHeight: 390)
                #endif
        }
    }
    
    struct DialogView: View {
        @Binding var isPresented: Bool
        @State private var isLoading: Bool = false
        @State private var searchTextUsers: String = ""
        @State private var assetsUsers = Mocks.multipleUsersDictionary
        @FocusState var isFocused
        
        var body: some View {
            PBDialog(title: "Dialog",
                     variant: .default,
                     onClose: { isPresented = false },
                     shouldCloseOnOverlay: false) {
                VStack {
                    PBTypeahead(
                        id: 4,
                        title: "Users",
                        placeholder: "type the name of a user",
                        searchText: $searchTextUsers,
                        options: $assetsUsers, 
                        selection: .multiple(variant: .pill),
                        dropdownMaxHeight: 300,
                        isFocused: $isFocused
                    ) { options in
                        print("Selected options \(options)")
                    }
                    Spacer()
                }
                .padding(Spacing.medium)
                .background(Color.white.opacity(0.01))
                .onTapGesture {
                    isFocused = false
                }
            }
        }
    }
}

#Preview {
    TypeaheadCatalog()
}
