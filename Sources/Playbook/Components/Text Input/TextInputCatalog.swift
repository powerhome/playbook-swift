//
//  TextInputCatalog.swift
//  
//
//  Created by Isis Silva on 03/08/23.
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

    let rightIcon =  AnyView(
      HStack(spacing: Spacing.xxSmall) {
        PBIcon.fontAwesome(.userCircle, size: .x1)
        PBIcon.fontAwesome(.chevronDown, size: .x1)
      }
    )

    #if os(iOS)
    let pbTextInputView = List {
      Section("Default") {
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

      Section("Event handler") {
        PBTextInput(
          "On change",
          text: $textOnChange,
          placeholder: "Enter first name",
          onChange: true
        )
      }

      Section("With error") {
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

      Section("Disabled") {
        PBTextInput(
          "Last name",
          text: $textDisabled,
          placeholder: "Enter last name",
          style: .disabled
        )
      }

      Section("Add on") {
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
          "LEFT-ALIGNED ADD ON WITH NO BORDER",
          text: $textAddOnLeftNoBorder,
          style: .leftIcon(.user, divider: true)
        )
      }
      .listRowSeparator(.hidden)

      Section("Inline") {
        PBTextInput(
          "HOVER OVER TEXT BELOW",
          text: $textInline,
          placeholder: "Inline Input",
          style: .inline
        )
      }
    }

    #elseif os(macOS)
    let pbTextInputView = ScrollView {
      Section("Default") {
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

      Section("Event handler") {
        PBTextInput(
          "First name",
          text: $textOnChange,
          placeholder: "Enter first name")
      }

      Section("With error") {
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

      Section("Disabled") {
        PBTextInput(
          "Last name",
          text: $textDisabled,
          placeholder: "Enter last name",
          style: .disabled
        )
      }

      Section("Add on") {
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
          "LEFT-ALIGNED ADD ON WITH NO BORDER",
          text: $textAddOnLeftNoBorder,
          style: .leftIcon(.user, divider: true)
        )
      }
    }.padding()
    #endif
    return pbTextInputView
  }
}
