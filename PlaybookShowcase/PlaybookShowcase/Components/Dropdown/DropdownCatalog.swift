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
  @State private var colorOptions: [String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Indigo", "Violet"]
  @State private var selectedText: String = ""
  @State private var selectedText1: String = ""
  @State private var selectedText2: String = ""
  @State private var selectedText3: String = ""
  @State private var selectedText4: String = ""
  @State private var selectedText5: String = ""
  @State private var selectedText6: String = ""
  @State private var selectedText7: String = ""
  @State private var label: String? = "Select a City"

  public var body: some View {
    PBDocStack(title: "Dropdown", spacing: Spacing.medium) {
      PBDoc(title: "Select Dropdown") { selectDropdown }
      PBDoc(title: "Select Plain Dropdown w/ Label") { selectPlainDropdown }
      PBDoc(title: "Select Dropdown w/ Icon") { selectIconDropdown }
      PBDoc(title: "Select Dropdown w/ Checkmark") { selectCheckmarkDropdown }
      PBDoc(title: "Select Dropdown w/ Icon & Checkmark") { selectCalendarIconDropdown }
      PBDoc(title: "Select Dropdown w/ Top Card") { selectCardTopDropdown }
      PBDoc(title: "Icon Dropdown") { iconDropdown }
      PBDoc(title: "Custom Dropdown") { customDropdown }
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
        label: $label,
        hasLabel: true,
        variant: .select,
        hasIcon: false,
        hasRowSeparator: false,
        hasCheckmark: false) {}
    }
    .frame(height: 210)
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

  var iconDropdown: some View {
    VStack {
      PBDropdown(
        options: $colorOptions,
        selectedText: $selectedText6,
        cardPosition: .leading,
        variant: .button,
        hasRowSeparator: true,
        dropdownWidth: 200,
        dropdownHeight: .iOS(130, macOS: 140)
      ) {}

    }
    .padding(.bottom, 115)
  }

  var customDropdown: some View {
    VStack {
      PBDropdown(
        options: $colorOptions,
        selectedText: $selectedText7,
        cardPosition: .top,
        topSpacing: 25,
        leadingSpacing: 150,
        variant: .custom,
        hasRowSeparator: true,
        dropdownWidth: 200,
        dropdownHeight: .iOS(130, macOS: 140)
      ) {
        Text("Click Me")
          .pbFont(.body, color: .text(.light))
      }
    }
    .padding(.bottom, 150)
  }
}

#Preview {
  registerFonts()
    return DropdownCatalog()
      #if os(macOS)
      .frame(width: 700, height: 600)
      #endif
}
