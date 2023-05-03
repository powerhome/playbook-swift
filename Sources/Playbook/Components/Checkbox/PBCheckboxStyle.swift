//
//  PBCheckboxStyle.swift
//
//
//  Created by Gavin Huang on 5/2/23.
//

import SwiftUI

struct PBCheckboxToggleStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    Button {
      configuration.isOn.toggle()
    } label: {
      HStack {
        Image(systemName: configuration.isOn ? "checkmark.square" : "square")

        configuration.label
      }
    }
  }
}

//public struct PBCheckboxStyle: ButtonStyle {
//  @State private var isChecked = false
//
//  private var borderColor: Color {
//    isChecked ? .pbPrimary : .border
//  }
//
//  var backgroundColor: Color {
//    isChecked ? Color.pbPrimary : Color.clear
//  }
//
//  public func makeBody(configuration: Configuration) -> some View {
//    HStack(alignment: .top) {
//      ZStack {
//        RoundedRectangle(cornerRadius: 4)
//          .strokeBorder(borderColor, lineWidth: 2)
//          .background(backgroundColor)
//          .clipShape(RoundedRectangle(cornerRadius: 4))
//          .frame(width: 22, height: 22)
//        PBIcon.fontAwesome(.check, size: .small)
//          .foregroundColor(Color.white)
//      }
//
//      VStack(alignment: .leading, spacing: 4) {
//        configuration.label
//          .foregroundColor(.text(.default))
//          .pbFont(.body())
//          .frame(minHeight: 22)
//      }
//    }
//    .frame(minWidth: 44, minHeight: 44)
//    .contentShape(Rectangle())
//  }
//}
