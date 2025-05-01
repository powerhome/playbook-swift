//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ReadOnlyTextFieldView.swift
//

import SwiftUI

struct ReadOnlyTextFieldView: View {
  @State private var placeholder = "Select"
  @Binding var isOpen: Bool
  @Binding var selectedText: String

  var body: some View {
    ZStack(alignment: .leading) {
      RoundedRectangle(cornerRadius: 8)
        .stroke(Color.clear, lineWidth: 1)
        .background(Color.white)
        .frame(height: 44)
      HStack {
        Text(placeholder)
          .pbFont(.body)
          .foregroundStyle(Color.text(.light))
          .padding(.horizontal, 8)

        PBIcon.fontAwesome(.chevronDown)
          .foregroundStyle(Color.text(.light))
          .frame(maxWidth: .infinity, alignment: .trailing)
      }
      .padding(.horizontal, 8)
    }
    .cornerRadius(8)
    .contentShape(Rectangle())
    .onTapGesture {
      isOpen.toggle()
    }
    .onChange(of: selectedText) {
      placeholder = selectedText.isEmpty ? "Select" : selectedText
    }
  }
}
