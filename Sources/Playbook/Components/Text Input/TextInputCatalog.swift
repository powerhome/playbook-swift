//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  TextInputCatalog.swift
//

import SwiftUI

struct TextInputCatalog: View {
  @State private var textFirstName: String = ""
  @State private var textLastName: String = ""
  @State private var textPhone: String = ""
  @State private var textEmail: String = ""
  @State private var textZip: String = ""
  @State private var textOnChange: String = ""
  @State private var textError: String = ""
  @State private var textConfirmError: String = ""
  @State private var textAddOn: String = ""
  @State private var textAddOnRight: String = ""
  @State private var textAddOnRightNoBorder: String = ""
  @State private var textAddOnLeft: String = ""
  @State private var textAddOnLeftNoBorder: String = ""
  @State private var textInline: String = ""
  @State private var textDisabled: String = ""

  var body: some View {
    registerFonts()
    #if os(iOS)
      let pbTextInputView = ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Default", spacing: Spacing.small) {
            PBTextInput(
              "First name",
              text: $textFirstName,
              placeholder: "Enter first name"
            )

            PBTextInput(
              "Last name",
              text: $textLastName,
              placeholder: "Enter last name"
            )

            PBTextInput(
              "Phone number",
              text: $textPhone,
              placeholder: "Enter phone number",
              keyboardType: .phonePad
            )

            PBTextInput(
              "Email",
              text: $textEmail,
              placeholder: "Enter email address",
              keyboardType: .emailAddress
            )

            PBTextInput(
              "Zip code",
              text: $textZip,
              placeholder: "Enter zip code",
              keyboardType: .numberPad
            )
          }
          .listRowSeparator(.hidden)

          PBDoc(title: "Event handler", spacing: Spacing.small) {
            PBTextInput(
              "On change",
              text: $textOnChange,
              placeholder: "Enter first name",
              onChange: true
            )
          }

          PBDoc(title: "With error", spacing: Spacing.small) {
            PBTextInput(
              "Email address",
              text: $textError,
              placeholder: "Enter email address",
              error: (true, "Insert a valid email"),
              style: .leftIcon(.user, divider: true)
            )

            PBTextInput(
              "Confirm email address",
              text: $textConfirmError,
              placeholder: "Confirm email address",
              style: .leftIcon(.user, divider: true)
            )
          }
          .listRowSeparator(.hidden)

          PBDoc(title: "Disabled") {
            PBTextInput(
              "Last name",
              text: $textDisabled,
              placeholder: "Enter last name",
              style: .disabled
            )
          }

          PBDoc(title: "Add on", spacing: Spacing.small) {
            PBTextInput(
              "ADD ON WITH DEFAULTS",
              text: $textAddOn,
              style: .rightIcon(.user, divider: true)
            )
            PBTextInput(
              "RIGHT-ALIGNED ADD ON WITH BORDER",
              text: $textAddOnRight,
              style: .rightIcon(.user, divider: true)
            )
            PBTextInput(
              "RIGHT-ALIGNED ADD ON WITH NO BORDER",
              text: $textAddOnRightNoBorder,
              style: .rightIcon(.user, divider: false)
            )
            PBTextInput(
              "LEFT-ALIGNED ADD ON WITH NO BORDER",
              text: $textAddOnLeft,
              style: .leftIcon(.user, divider: false)
            )
            PBTextInput(
              "LEFT-ALIGNED ADD ON WITH BORDER",
              text: $textAddOnLeftNoBorder,
              style: .leftIcon(.user, divider: true)
            )
          }
          .listRowSeparator(.hidden)

          PBDoc(title: "Inline") {
            PBTextInput(
              "HOVER OVER TEXT BELOW",
              text: $textInline,
              placeholder: "Inline Input",
              style: .inline
            )
          }
        }
        .padding(Spacing.medium)
      }
      .navigationTitle("Text Input")

    #elseif os(macOS)
      let pbTextInputView = ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Default", spacing: Spacing.small) {
            PBTextInput(
              "First name",
              text: $textFirstName,
              placeholder: "Enter first name"
            )

            PBTextInput(
              "Last name",
              text: $textLastName,
              placeholder: "Enter first name"
            )

            PBTextInput(
              "Phone number",
              text: $textPhone,
              placeholder: "Enter first name"
            )

            PBTextInput(
              "Email",
              text: $textEmail,
              placeholder: "Enter first name"
            )

            PBTextInput(
              "Zip code",
              text: $textZip,
              placeholder: "Enter first name"
            )
          }

          PBDoc(title: "Event handler", spacing: Spacing.small) {
            PBTextInput(
              "First name",
              text: $textOnChange,
              placeholder: "Enter first name")
          }

          PBDoc(title: "With error", spacing: Spacing.small) {
            PBTextInput(
              "Email address",
              text: $textError,
              placeholder: "Enter email address",
              error: (true, "Insert a valid email"),
              style: .leftIcon(.user, divider: true)
            )

            PBTextInput(
              "Confirm email address",
              text: $textConfirmError,
              placeholder: "Confirm email address",
              style: .leftIcon(.user, divider: true)
            )
          }

          PBDoc(title: "Disabled") {
            PBTextInput(
              "Last name",
              text: $textDisabled,
              placeholder: "Enter last name",
              style: .disabled
            )
          }

          PBDoc(title: "Add on", spacing: Spacing.small) {
            PBTextInput(
              "ADD ON WITH DEFAULTS",
              text: $textAddOn,
              style: .leftIcon(.user, divider: true)
            )
            PBTextInput(
              "RIGHT-ALIGNED ADD ON WITH BORDER",
              text: $textAddOnRight,
              style: .leftIcon(.user, divider: true)
            )
            PBTextInput(
              "RIGHT-ALIGNED ADD ON WITH NO BORDER",
              text: $textAddOnRightNoBorder,
              style: .rightIcon(.user, divider: false)
            )
            PBTextInput(
              "LEFT-ALIGNED ADD ON WITH NO BORDER",
              text: $textAddOnLeft,
              style: .leftIcon(.user, divider: false)
            )
            PBTextInput(
              "LEFT-ALIGNED ADD ON WITH BORDER",
              text: $textAddOnLeftNoBorder,
              style: .leftIcon(.user, divider: true)
            )
          }
        }
        .padding(Spacing.medium)
      }
    #endif
    return pbTextInputView
  }
}
