//
//  ColorsCatalog.swift
//  
//
//  Created by Isis Silva on 15/02/23.
//

import SwiftUI

struct ColorsCatalog: View {
  var body: some View {
    let shape = Circle().frame(width: 60)
    List {
      Section("Text Colors") {
        HStack {
          ForEach(PBColor.TextColor.allCases, id: \.self) { color in
            shape.pbForegroundColor(.text(color))
          }
        }
      }

      Section("Background Colors") {
        HStack {
          ForEach(PBColor.BackgroundColor.allCases, id: \.self) { color in
            shape.pbForegroundColor(.background(color))
          }
        }
      }

      Section("Status Colors") {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
          ForEach(PBColor.StatusColor.allCases, id: \.self) { color in
            VStack {
              shape.pbForegroundColor(.status(color))
              Text(color.rawValue).pbFont(.caption, color: .light)
            }
          }
        }
      }

      Section("Product Colors") {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
          ForEach(PBColor.ProductColor.allCases, id: \.self) { color in
            VStack {
              shape.pbForegroundColor(.product(color))
              Text(color.rawValue).pbFont(.caption, color: .light)
            }
          }
        }
      }
    }
  }
}

struct ColorsCatalog_Previews: PreviewProvider {
  static var previews: some View {
    ColorsCatalog()
  }
}
