//
//  TextInputCatalog.swift
//  
//
//  Created by Isis Silva on 03/08/23.
//

import SwiftUI

struct TextInputCatalog: View {
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
            placeholder: "Enter first name",
            rightActionIcon: .custom(rightIcon, action: { print("Hello") })
          )

          PBTextInput(
            "Last name",
            placeholder: "Enter last name",
            rightActionIcon: .custom(rightIcon, action: { print("Hello") })
          )

          PBTextInput(
            "Phone number",
            placeholder: "Enter phone number",
            keyboardType: .phonePad,
            rightActionIcon: .custom(rightIcon, action: { print("Hello") })
          )

          PBTextInput(
            "Email",
            placeholder: "Enter email address",
            keyboardType: .emailAddress,
            rightActionIcon: .custom(rightIcon, action: { print("Hello") })
          )

          PBTextInput(
            "Zip code",
            placeholder: "Enter zip code",
            keyboardType: .numberPad,
            rightActionIcon: .custom(rightIcon, action: { print("Hello") })
          )
        }
        .listRowSeparator(.hidden)

        Section("Event handler") {
          PBTextInput(
            "On change",
            placeholder: "Enter first name",
            onChange: true
          )
        }

        Section("With error") {
          PBTextInput(
            "Email address",
            placeholder: "Enter email address",
            error: (true, "Insert a valid email"),
            style: .leftIcon((.user, { print("Hello") }), divider: true)
          )

          PBTextInput(
            "Confirm email address",
            placeholder: "Confirm email address",
            style: .leftIcon((.user, { print("Hello") }), divider: true)
          )
        }
        .listRowSeparator(.hidden)

        Section("Disabled") {
          PBTextInput(
            "Last name",
            placeholder: "Enter last name",
            style: .disabled
          )
        }

        Section("Add on") {
          PBTextInput(
            "ADD ON WITH DEFAULTS",
            style: .rightIcon((.user, { print("Hello") }), divider: true)
          )
          PBTextInput(
            "RIGHT-ALIGNED ADD ON WITH BORDER",
            style: .rightIcon((.user, { print("Hello") }), divider: true)
          )
          PBTextInput(
            "RIGHT-ALIGNED ADD ON WITH NO BORDER",
            style: .rightIcon((.user, { print("Hello") }), divider: false)
          )
          PBTextInput(
            "LEFT-ALIGNED ADD ON WITH NO BORDER",
            style: .leftIcon((.user, { print("Hello") }), divider: false)
          )
          PBTextInput(
            "LEFT-ALIGNED ADD ON WITH NO BORDER",
            style: .leftIcon((.user, { print("Hello") }), divider: true)
          )
        }
        .listRowSeparator(.hidden)

        Section("Inline") {
          PBTextInput(
            "HOVER OVER TEXT BELOW",
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
            placeholder: "Enter first name",
            rightActionIcon: .custom(rightIcon, action: { print("Hello") })
          )

          PBTextInput(
            "Last name",
            placeholder: "Enter first name",
            rightActionIcon: .custom(rightIcon, action: { print("Hello") })
          )

          PBTextInput(
            "Phone number",
            placeholder: "Enter first name",
      //          keyboardType: .phonePad,
            rightActionIcon: .custom(rightIcon, action: { print("Hello") })
          )

          PBTextInput(
            "Email",
            placeholder: "Enter first name",
      //          keyboardType: .emailAddress,
            rightActionIcon: .custom(rightIcon, action: { print("Hello") })
          )

          PBTextInput(
            "Zip code",
            placeholder: "Enter first name",
      //          keyboardType: .numberPad,
            rightActionIcon: .custom(rightIcon, action: { print("Hello") })
          )
            }

        Section("Event handler") {
          PBTextInput(
            "First name",
            placeholder: "Enter first name")
        }

        Section("With error") {
          PBTextInput(
            "Email address",
            placeholder: "Enter email address",
            error: (true, "Insert a valid email"),
            style: .leftIcon((.user, { print("Hello") }), true)
          )

          PBTextInput(
            "Confirm email address",
            placeholder: "Confirm email address",
            style: .leftIcon((.user, { print("Hello") }), true)
          )
        }

        Section("Disabled") {
          PBTextInput(
            "Last name",
            placeholder: "Enter last name",
            style: .disabled
          )
        }

        Section("Add on") {
          PBTextInput(
            "ADD ON WITH DEFAULTS",
            style: .leftIcon((.user, { print("Hello") }), true)
          )
          PBTextInput(
            "RIGHT-ALIGNED ADD ON WITH BORDER",
            style: .leftIcon((.user, { print("Hello") }), true)
          )
          PBTextInput(
            "RIGHT-ALIGNED ADD ON WITH NO BORDER",
            style: .rightIcon((.user, { print("Hello") }), false)
          )
          PBTextInput(
            "LEFT-ALIGNED ADD ON WITH NO BORDER",
            style: .leftIcon((.user, { print("Hello") }), false)
          )
          PBTextInput(
            "LEFT-ALIGNED ADD ON WITH NO BORDER",
            style: .leftIcon((.user, { print("Hello") }), true)
          )
        }

       }.padding()

   #endif

      return pbTextInputView
    }
}
