//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  TypeaheadCatalog.swift
//

import SwiftUI
import Playbook

public struct TypeaheadCatalog: View {
  private var assetsColors = Mocks.assetsColors
  @State private var searchTextColors: String = ""
  @State private var selectedColors: [PBTypeahead.Option] = [Mocks.assetsColors[2]]
  @FocusState private var isFocusedColors

  private var assetsUsers = Mocks.assetesMultipleUsers
  @State private var searchTextUsers: String = ""
  @State private var selectedUsers: [PBTypeahead.Option] = [
    Mocks.assetesMultipleUsers[0],
    Mocks.assetesMultipleUsers[1]
  ]
  @FocusState private var isFocusedUsers

  @State private var searchTextDeselectedUsers: String = ""
  @State private var selectedUsersDeselected: [PBTypeahead.Option] = [
    Mocks.assetesMultipleUsers[0],
    Mocks.assetesMultipleUsers[1]
  ]
  @State private var deselectedUsers: [PBTypeahead.Option] = []
  @FocusState private var isFocusedDeselectedUsers

  @State private var searchTextHeight: String = ""
  @State private var selectedHeight: [PBTypeahead.Option] = [
    Mocks.assetesMultipleUsers[3],
    Mocks.assetesMultipleUsers[2]
  ]
  @FocusState private var isFocusedHeight

  private var assetsSection: [PBTypeahead.OptionType] = Mocks.assetsSectionUsers
  @State private var searchTextSections: String = ""
  @State private var selectedSections: [PBTypeahead.Option] = []
  @FocusState private var isFocusedSection

  @State private var searchTextNoOptions: String = ""
  @State private var selectedNoOptions: [PBTypeahead.Option] = []
  @FocusState private var isFocusedNoOptions

  @State private var presentDialog: Bool = false
  private var popoverManager = PopoverManager.shared

  public var body: some View {
    PBDocStack(title: "Typeahead") {
      PBDoc(title: "Default", spacing: Spacing.small) { colors }
      PBDoc(title: "With Pills", spacing: Spacing.small) { users }
      PBDoc(title: "Deselected listener", spacing: Spacing.small) { deselectedUsersDoc }
      #if os(macOS)
      PBDoc(title: "Dialog") { dialog }
      #endif
      PBDoc(title: "Height Adjusted Dropdown", spacing: Spacing.small) { heightAdjusted }
      PBDoc(title: "Sections", spacing: Spacing.small) { sections }
      PBDoc(title: "No Options", spacing: Spacing.small) { noOptions }
        .padding(.bottom, 500)
    }
    .scrollDismissesKeyboard(.immediately)
    .onTapGesture {
      dismissFocus()
    }
    .popoverHandler(id: 1)
    .popoverHandler(id: 2)
    .popoverHandler(id: 3)
    .popoverHandler(id: 4)
    .popoverHandler(id: 5)
  }
}

extension TypeaheadCatalog {
  var colors: some View {
    PBTypeahead(
      id: 1,
      title: "Colors",
      searchText: $searchTextColors,
      options: assetsColors,
      selection: .single,
      isFocused: $isFocusedColors,
      selectedOptions: $selectedColors
    )
  }

  var users: some View {
    PBTypeahead(
      id: 2,
      title: "Users",
      placeholder: "type the name of a user",
      searchText: $searchTextUsers,
      options: assetsUsers,
      selection: .multiple(variant: .pill),
      isFocused: $isFocusedUsers,
      selectedOptions: $selectedUsers
    )
  }

  var deselectedUsersDoc: some View {
    VStack(spacing: 32) {
      PBTypeahead(
        id: 5,
        title: "Users",
        placeholder: "type the name of a user",
        searchText: $searchTextDeselectedUsers,
        options: assetsUsers,
        selection: .multiple(variant: .pill),
        isFocused: $isFocusedDeselectedUsers,
        selectedOptions: $selectedUsersDeselected,
        deselectedOptions: $deselectedUsers
      )
      List(deselectedUsers, id: \.id) { user in
        Text(user.text ?? "")
      }
      .listStyle(.plain)
      .frame(height: 100)
    }
  }

  var heightAdjusted: some View {
    PBTypeahead(
      id: 3,
      title: "Users",
      placeholder: "type the name of a user",
      searchText: $searchTextHeight,
      options: assetsUsers,
      selection: .multiple(variant: .pill),
      dropdownMaxHeight: 150,
      isFocused: $isFocusedHeight,
      selectedOptions: $selectedHeight
    )
  }

  var sections: some View {
    PBTypeaheadTemplate(
      id: 4,
      title: "Sections",
      searchText: $searchTextSections,
      options: assetsSection,
      selection: .multiple(variant: .pill),
      dropdownMaxHeight: 400,
      isFocused: $isFocusedSection,
      selectedOptions: $selectedSections
    )
  }

  var noOptions: some View {
    PBTypeahead(
      id: 5,
      title: "Users",
      placeholder: "type the name of a user",
      searchText: $searchTextNoOptions,
      options: assetsUsers,
      selection: .multiple(variant: .pill),
      isFocused: $isFocusedNoOptions,
      selectedOptions: $selectedNoOptions,
      noOptionsView: {
        customNoOptionsText
      }
    )
  }

  var customNoOptionsText: some View {
    #if os(macOS)
    HStack(spacing: Spacing.none) {
      Text("No results found. Review user name for accuracy or ")
      PBButton(variant: .link, title: "add user name.")
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .pbFont(.detail(false), color: .text(.light))
    #elseif os(iOS)
    VStack {
      Text("No results found. Review user name for accuracy or ")
      PBButton(variant: .link, title: "add user name.")
    }
    .fixedSize(horizontal: true, vertical: false)
    .pbFont(.detail(false), color: .text(.light))
    #endif
  }

  var dialog: some View {
    PBButton(title: "Simple") {
      DialogCatalog.disableAnimation()
      presentDialog.toggle()
    }
    .presentationMode(isPresented: $presentDialog) {
      DialogView(isPresented: $presentDialog)
        .popoverHandler(id: 6)
      #if os(macOS)
        .frame(minWidth: 500, minHeight: 390)
      #endif
    }
  }

  func closeToast() {
    presentDialog = false
  }

  struct DialogView: View {
    @Binding var isPresented: Bool
    @State private var isLoading: Bool = false
    @State private var searchTextUsers: String = ""
    @State private var assetsUsers = Mocks.assetesMultipleUsers
    @State private var selectedUsers: [PBTypeahead.Option] = [
      Mocks.assetesMultipleUsers[0],
      Mocks.assetesMultipleUsers[1]
    ]
    @FocusState var isFocused

    var body: some View {
      PBDialog(title: "Dialog",
               variant: .default,
               onClose: { isPresented = false },
               shouldCloseOnOverlay: false) {
        VStack {
          PBTypeahead(
            id: 6,
            title: "Users",
            placeholder: "type the name of a user",
            searchText: $searchTextUsers,
            options: assetsUsers,
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

  func dismissFocus() {
    isFocusedColors = false
    isFocusedUsers = false
    isFocusedHeight = false
    isFocusedSection = false
    Task {
      await popoverManager.dismissPopovers()
    }
  }
}

#Preview {
  TypeaheadCatalog()
}
