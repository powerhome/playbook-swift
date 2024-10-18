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
    @State private var selectedAssetsColors: [(String, (String, (() -> AnyView?)?)?)] = []
    @State private var assetsUsers = Mocks.multipleUsersDictionary
    @State private var selectedUsers: [(String, (String, (() -> PBUser?)?)?)] = [
        ("1", (Mocks.andrew.name, { Mocks.andrew })),
        ("2", (Mocks.ana.name, { Mocks.ana }))
    ]
    @State private var selectedUsers1: [(String, (String, (() -> PBUser?)?)?)] = [
        ("1", (Mocks.andrew.name, { Mocks.andrew })),
        ("2", (Mocks.ana.name, { Mocks.ana }))
    ]
  @State private var selectedSections: [(String, (String, (() -> PBUser?)?)?)] = []
    @State private var searchTextUsers: String = ""
    @State private var searchTextUsers1: String = ""
    @State private var searchTextColors: String = ""
    @State private var searchTextSections: String = ""
    @State private var searchText: String = ""
    @State private var searchTextDebounce: String = ""
    @State private var didTapOutside: Bool? = false
    @State private var isPresented1: Bool = false
    @State private var presentDialog: Bool = false
    @State private var isLoading: Bool = false
    @State private var assetsUser = Mocks.multipleUsersDictionary
    @FocusState var isFocused1
    @FocusState var isFocused2
    @FocusState var isFocused3
    @FocusState var isFocused4
    @State private var sectionUsers: [PBTypeaheadTemplate.OptionType] = [
        .section("section 1"),
        .item(("1", (Mocks.andrew.name, { Mocks.andrew }))),
        .item(("2", (Mocks.ana.name, { Mocks.ana }))),
        .item(("3", (Mocks.patric.name, { Mocks.patric }))),
        .item(("4", (Mocks.luccile.name, { Mocks.luccile }))),
        .section("section 2"),
        .item(("1", (Mocks.andrew.name, { Mocks.andrew }))),
        .item(("2", (Mocks.ana.name, { Mocks.ana }))),
        .item(("3", (Mocks.patric.name, { Mocks.patric }))),
        .item(("4", (Mocks.luccile.name, { Mocks.luccile })))
    ]
    var popoverManager = PopoverManager()

    public var body: some View {
        PBDocStack(title: "Typeahead") {
            PBDoc(title: "Default", spacing: Spacing.small) { colors }
            PBDoc(title: "With Pills", spacing: Spacing.small) { users }
            PBDoc(title: "Height Adjusted Dropdown", spacing: Spacing.small) { heightAdjusted }
            #if os(macOS)
            PBDoc(title: "Dialog") { dialog }
            #endif
            PBDoc(title: "Sections", spacing: Spacing.small) { sections }
                .padding(.bottom, 500)

        }
        .onTapGesture {
            isFocused1 = false
            isFocused2 = false
            isFocused3 = false
            isFocused4 = false
        }
        .popoverHandler(id: 1)
        .popoverHandler(id: 2)
        .popoverHandler(id: 3)
        .popoverHandler(id: 4)
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
        )
    }

    var users: some View {
        PBTypeahead(
            id: 2,
            title: "Users",
            placeholder: "type the name of a user",
            searchText: $searchTextUsers,
            options: $assetsUsers,
            selection: .multiple(variant: .pill),
            isFocused: $isFocused2,
            selectedOptions: $selectedUsers
        )
    }

    var heightAdjusted: some View {
        PBTypeahead(
            id: 3,
            title: "Users",
            placeholder: "type the name of a user",
            searchText: $searchTextUsers1,
            options: $assetsUsers,
            selection: .multiple(variant: .pill),
            dropdownMaxHeight: 150,
            isFocused: $isFocused3,
            selectedOptions: $selectedUsers1
        )
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

    var sections: some View {
        PBTypeaheadTemplate(
            id: 4,
            title: "Sections",
            searchText: $searchTextSections,
            options: $sectionUsers,
            selection: .multiple(variant: .pill),
            isFocused: $isFocused4,
            selectedOptions: $selectedSections
        )
    }

    func closeToast() {
        presentDialog = false
    }

    struct DialogView: View {
        @Binding var isPresented: Bool
        @State private var isLoading: Bool = false
        @State private var searchTextUsers: String = ""
        @State private var assetsUsers = Mocks.multipleUsersDictionary
        @State private var selectedUsers: [(String, (String, (() -> PBUser?)?)?)] = [
            ("1", (Mocks.andrew.name, { Mocks.andrew })),
            ("2", (Mocks.ana.name, { Mocks.ana }))
        ]
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
                        isFocused: $isFocused,
                        selectedOptions: $selectedUsers
                    )
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
