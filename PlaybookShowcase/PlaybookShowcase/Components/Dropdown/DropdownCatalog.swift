//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  DropdownCatalog.swift
//

import SwiftUI
import Playbook

public struct DropdownCatalog: View {
  @State var colorOptions: [String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Indigo", "Violet"]
  @State var selectedText: String = ""
  @State var selectedText1: String = ""
  @State var selectedText2: String = ""
  @State var selectedText3: String = ""
  @State var selectedText4: String = ""
  @State var selectedText5: String = ""

  public var body: some View {
    PBDocStack(title: "Dropdown", spacing: Spacing.medium) {
      PBDoc(title: "Select Dropdown") { selectDropdown }
      PBDoc(title: "Select Plain Dropdown") { selectPlainDropdown }
      PBDoc(title: "Select Dropdown w/ Icon") { selectIconDropdown }
      PBDoc(title: "Select Dropdown w/ Checkmark") { selectCheckmarkDropdown }
      PBDoc(title: "Select Dropdown w/ Icon & Checkmark") { selectCalendarIconDropdown }
      PBDoc(title: "Select Dropdown w/ Top Card") { selectCardTopDropdown }
    }
  }
}

extension DropdownCatalog {
  var selectDropdown: some View {
    VStack(spacing: Spacing.medium) {
      PBDropdown(
        selectedText: $selectedText,
        variant: .select,
        hasIcon: false,
        hasRowSeparator: true,
        hasCheckmark: false) {}
    }
    .frame(height: 200)
  }

  var selectPlainDropdown: some View {
    VStack(spacing: Spacing.medium) {
      PBDropdown(
        selectedText: $selectedText1,
        variant: .select,
        hasIcon: false,
        hasRowSeparator: false,
        hasCheckmark: false) {}
    }
    .frame(height: 200)
  }

  var selectIconDropdown: some View {
    VStack(spacing: Spacing.medium) {
      PBDropdown(
        selectedText: $selectedText2,
        dropdownIcon: .calendar,
        dropdownIconSize: .small,
        variant: .select,
        hasIcon: true,
        hasRowSeparator: true,
        hasCheckmark: false) {}
    }
    .frame(height: 200)
  }

  var selectCheckmarkDropdown: some View {
    VStack(spacing: Spacing.medium) {
      PBDropdown(
        selectedText: $selectedText3,
        variant: .select,
        hasIcon: false,
        hasRowSeparator: true,
        hasCheckmark: true) {}
    }
    .frame(height: 200)
  }

  var selectCalendarIconDropdown: some View {
    VStack(spacing: Spacing.medium) {
      PBDropdown(
        selectedText: $selectedText4,
        dropdownIcon: .calendar,
        dropdownIconSize: .small,
        variant: .select,
        hasIcon: true,
        hasRowSeparator: true,
        hasCheckmark: true
      ) {}
    }
    .frame(height: 200)
  }

  var selectCardTopDropdown: some View {
    VStack {
      PBDropdown(
        options: $colorOptions,
        selectedText: $selectedText5,
        cardPosition: .bottom,
        variant: .select,
        hasIcon: false,
        hasRowSeparator: true,
        hasCheckmark: false
      ) {}
        .padding(.top, 175)

    }
    .frame(height: 200)
  }
}

#Preview {
  registerFonts()
    return DropdownCatalog()
      #if os(macOS)
      .frame(width: 700, height: 600)
      #endif
}
