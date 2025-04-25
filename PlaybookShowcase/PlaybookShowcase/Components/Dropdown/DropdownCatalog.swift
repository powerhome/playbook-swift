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
  var options: [String] = ["Red", "Orange", "Yellow", "Green", "Blue", "Indigo", "Violet"]
  public var body: some View {
    PBDocStack(title: "Dropdown", spacing: Spacing.medium) {
      PBDoc(title: "Select Dropdown") { selectPlainDropdown }
      PBDoc(title: "Select Dropdown w/ Icon") { selectIconDropdown }
      PBDoc(title: "Select Dropdown w/ Checkmark") { selectCheckmarkDropdown }
      PBDoc(title: "Select Dropdown w/ Icon & Checkmark") { selectCalendarIconDropdown }
      PBDoc(title: "Select Dropdown w/ Top Card") { selectCardTopDropdown }
      PBDoc(title: "Button Dropdown") { buttonDropdown }
      PBDoc(title: "Button Leading Dropdown") { buttonDropdownLeading }
      PBDoc(title: "Custom Dropdown") { customTriggerDropdown }
    }
  }
}

extension DropdownCatalog {
  var selectPlainDropdown: some View {
    VStack(spacing: Spacing.medium) {
      PBDropdown(
        variant: .select,
        hasIcon: false,
        hasRowSeparator: false,
        hasCheckmark: false) {}

      PBDropdown(
        variant: .select,
        hasIcon: false,
        hasRowSeparator: true,
        hasCheckmark: false) {}
    }
    .frame(height: 350)
  }

  var selectIconDropdown: some View {
    VStack(spacing: Spacing.medium) {
      PBDropdown(
        dropdownIcon: .calendar,
        dropdownIconSize: .small,
        variant: .select,
        hasIcon: true,
        hasRowSeparator: true,
        hasCheckmark: false) {}

      PBDropdown(
        dropdownIcon: .calendar,
        dropdownIconSize: .small,
        variant: .select,
        hasIcon: true,
        hasRowSeparator: false,
        hasCheckmark: false) {}
    }
    .frame(height: 400)
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  var selectCheckmarkDropdown: some View {
    VStack(spacing: Spacing.medium) {
      PBDropdown(
        variant: .select,
        hasIcon: false,
        hasRowSeparator: true,
        hasCheckmark: true) {}

      PBDropdown(
        variant: .select,
        hasIcon: false,
        hasRowSeparator: false,
        hasCheckmark: true) {}
    }
    .frame(height: 360)
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  var selectCalendarIconDropdown: some View {
    VStack(spacing: Spacing.medium) {
      PBDropdown(
        dropdownIcon: .calendar,
        dropdownIconSize: .small,
        variant: .select,
        hasIcon: true,
        hasRowSeparator: true,
        hasCheckmark: true
      ) {}

      PBDropdown(
        dropdownIcon: .calendar,
        dropdownIconSize: .small,
        variant: .select,
        hasIcon: true,
        hasRowSeparator: false,
        hasCheckmark: true
      ) {}
    }
    .frame(height: 360)
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  var selectCardTopDropdown: some View {
    VStack {
      PBDropdown(
        options: options,
        cardPosition: .bottom,
        variant: .select,
        hasIcon: false,
        hasRowSeparator: true,
        hasCheckmark: false
      ) {}
        .padding(.top, 100)
    }
    .frame(height: 175)
    .frame(maxWidth: .infinity, alignment: .topLeading)
  }

  var buttonDropdown: some View {
    VStack {
      PBDropdown(
        cardPosition: .topLeading,
        topSpacing: 60,
        variant: .button,
        hasIcon: false,
        hasRowSeparator: true,
        hasCheckmark: false
      ) {}
      Spacer(minLength: 50)
    }
    .frame(height: 200)
    .frame(maxWidth: .infinity, alignment: .topLeading)
  }

  var buttonDropdownLeading: some View {
    HStack {
      PBDropdown(
        options: options,
        cardPosition: .leading,
        bottomSpacing: 40,
        leadingSpacing: 70,
        variant: .button,
        hasIcon: false,
        hasRowSeparator: true,
        hasCheckmark: false,
        width: 200
      ) {}
    }
    .frame(height: 175)
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  var customTriggerDropdown: some View {
    VStack {
      PBDropdown(
        cardPosition: .topLeading,
        topSpacing: 30,
        variant: .content,
        hasIcon: false,
        hasRowSeparator: true,
        hasCheckmark: false) {
          Text("Click Here")
            .pbFont(.body, color: .text(.light))
        }
        .padding(.top, -75)
    }
    .frame(height: 175)
    .frame(maxWidth: .infinity, alignment: .topLeading)
  }
}

#Preview {
  registerFonts()
    return DropdownCatalog()
      #if os(macOS)
      .frame(width: 700, height: 600)
      #endif
}
