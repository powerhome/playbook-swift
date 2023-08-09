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
          placeholder: "Enter first name"
        )
        
        PBTextInput(
          "Last name",
          placeholder: "Enter last name"
        )
        
        PBTextInput(
          "Phone number",
          placeholder: "Enter phone number",
          keyboardType: .phonePad
        )
        
        PBTextInput(
          "Email",
          placeholder: "Enter email address",
          keyboardType: .emailAddress
        )
        
        PBTextInput(
          "Zip code",
          placeholder: "Enter zip code",
          keyboardType: .numberPad
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
          style: .leftIcon(.user, divider: true)
        )
        
        PBTextInput(
          "Confirm email address",
          placeholder: "Confirm email address",
          style: .leftIcon(.user, divider: true)
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
          style: .rightIcon(.user, divider: true)
        )
        PBTextInput(
          "RIGHT-ALIGNED ADD ON WITH BORDER",
          style: .rightIcon(.user, divider: true)
        )
        PBTextInput(
          "RIGHT-ALIGNED ADD ON WITH NO BORDER",
          style: .rightIcon(.user, divider: false)
        )
        PBTextInput(
          "LEFT-ALIGNED ADD ON WITH NO BORDER",
          style: .leftIcon(.user, divider: false)
        )
        PBTextInput(
          "LEFT-ALIGNED ADD ON WITH NO BORDER",
          style: .leftIcon(.user, divider: true)
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
          title: "First name",
          placeholder: "Enter first name"
        )
        
        PBTextInput(
          "Last name",
          placeholder: "Enter first name"
        )
        
        PBTextInput(
          "Phone number",
          placeholder: "Enter first name"
        )
        
        PBTextInput(
          "Email",
          placeholder: "Enter first name"
        )
        
        PBTextInput(
          "Zip code",
          placeholder: "Enter first name"
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
          style: .leftIcon(.user, divider: true)
        )
        
        PBTextInput(
          "Confirm email address",
          placeholder: "Confirm email address",
          style: .leftIcon(.user, divider: true)
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
          style: .leftIcon(.user, divider: true)
        )
        PBTextInput(
          "RIGHT-ALIGNED ADD ON WITH BORDER",
          style: .leftIcon(.user, divider: true)
        )
        PBTextInput(
          "RIGHT-ALIGNED ADD ON WITH NO BORDER",
          style: .rightIcon(.user, divider: false)
        )
        PBTextInput(
          "LEFT-ALIGNED ADD ON WITH NO BORDER",
          style: .leftIcon(.user, divider: false)
        )
        PBTextInput(
          "LEFT-ALIGNED ADD ON WITH NO BORDER",
          style: .leftIcon(.user, divider: true)
        )
      }
      
    }.padding()
    #endif
    return pbTextInputView
  }
}
