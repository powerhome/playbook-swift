//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  BorderRadiusCatalog.swift
//

import SwiftUI

struct BorderRadiusCatalog: View {
  var body: some View {
    List(BorderRadius.allCase, id: \.self.0) { radius in
      Section("\(radius.1) - \(Int(radius.0))px") {
        RoundedRectangle(cornerRadius: radius.0)
          .fill(Color.background(.light))
          .frame(width: 100, height: 100)
          .overlay(
            RoundedRectangle(cornerRadius: radius.0)
              .stroke(Color.border, lineWidth: 1)
          )
      }
      .listRowBackground(Color.background(.default))
    }
    .navigationTitle("Border Radius")
  }
}

struct BorderRadiusCatalog_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return BorderRadiusCatalog()
  }
}
