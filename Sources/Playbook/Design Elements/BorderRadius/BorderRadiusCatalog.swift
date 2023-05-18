//
//  BorderRadiusCatalog.swift
//  
//
//  Created by Isis Silva on 17/05/23.
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
        .listRowBackground(Color.card)
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
