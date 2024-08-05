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
    @State private var searchText: String = ""
    @State private var searchTextDebounce: String = ""
    @State private var didTapOutside: Bool? = false
    @State private var isPresented1: Bool = false
    
    @State private var presentDialog: Bool = false
    @State private var presentDialog1: Bool = false
    @State private var isLoading: Bool = false
    
    @State private var assetsUser = Mocks.multipleUsersDictionary
    @FocusState var isFocused
    
    var popoverManager = PopoverManager()
    @FocusState var isFocused1
    @FocusState var isFocused2
    
    @State private var toastView: PBToast?
    @State private var position: PBToast.Position = .top
    
    public var body: some View {
        PBDocStack(title: "Typeahead") {
            PBDoc(title: "Default", spacing: Spacing.small) { colors }
            PBDoc(title: "With Pills", spacing: Spacing.small) { users }
            //      PBDoc(title: "Debounce", spacing: Spacing.small) { debounce }
            PBDoc(title: "Custom Dialog") { customDialog }
            PBDoc(title: "Dialog") { dialog }
        }
        .onTapGesture {
            isFocused1 = false
            isFocused2 = false
        }
        .popoverHandler(id: 1)
        .popoverHandler(id: 2)
//        .popoverHandler(id: 3)
//        .popoverHandler(id: )
    }
}

extension TypeaheadCatalog {
    var colors: some View {
        PBTypeahead(
            id: 1,
            title: "Colors",
            searchText: $searchTextColors,
            selection: .single,
            options: assetsColors,
            isFocused: $isFocused1
        ) {_ in }
    }
    
    var users: some View {
        PBTypeahead(
            id: 2,
            title: "Users",
            placeholder: "type the name of a user",
            searchText: $searchTextUsers,
            selection: .multiple(variant: .pill),
            options: assetsUsers,
            isFocused: $isFocused2
        ) {_ in }
    }
    
    func closeToast() {
        presentDialog = false
    }
    
    var customDialog: some View {
        PBButton(title: "Simple") {
            DialogCatalog.disableAnimation()
            presentDialog1.toggle()
        }
        .sheet(isPresented: $presentDialog1) {
            CustomDialogView(isPresented: $presentDialog1)
                .popoverHandler(id: 3)
#if os(macOS)
                .frame(minWidth: 500, minHeight: 390)
#endif
        }
    }
    
    var dialog: some View {
        PBButton(title: "Simple") {
            DialogCatalog.disableAnimation()
            presentDialog.toggle()
        }
        .sheet(isPresented: $presentDialog) {
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
                        selection: .multiple(variant: .pill),
                        options: assetsUsers,
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
    
    struct CustomDialogView: View {
        @Binding var isPresented: Bool
        @State private var isLoading: Bool = false
        @State private var searchTextUsers: String = ""
        @State private var assetsUsers = Mocks.multipleUsersDictionary
        @FocusState var isFocused
        
        var body: some View {
            VStack {
                HStack {
                    Spacer()
                    PBButton(icon: PBIcon.fontAwesome(.times)) {
                        isPresented = false
                    }
                }
                PBTypeahead(
                    id: 3,
                    title: "Users",
                    placeholder: "type the name of a user",
                    searchText: $searchTextUsers,
                    selection: .multiple(variant: .pill),
                    options: assetsUsers,
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

#Preview {
    TypeaheadCatalog()
}
