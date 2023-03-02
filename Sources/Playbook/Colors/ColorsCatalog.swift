//
//  ColorsCatalog.swift
//  
//
//  Created by Isis Silva on 15/02/23.
//

import SwiftUI

#if DEBUG
struct ColorsCatalog: View {
  var body: some View {
    let shape = Circle().frame(width: 60).pbShadow(.deep)
    List {
      Section("Main Colors") {
        HStack {
          ForEach(Color.MainColor.allCases, id: \.self) { color in
            shape.foregroundColor(.main(color))
          }
        }
      }

      Section("Text Colors") {
        HStack {
          ForEach(Color.TextColor.allCases, id: \.self) { color in
            shape.foregroundColor(.text(color))
          }
        }
      }

      Section("Background Colors") {
        HStack {
          ForEach(Color.BackgroundColor.allCases, id: \.self) { color in
            shape.foregroundColor(.background(color))
          }
        }
      }

      Section("Status Colors") {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
          ForEach(Color.StatusColor.allCases, id: \.self) { color in
            VStack {
              shape.foregroundColor(.status(color))
              Text(color.rawValue).pbFont(.caption, color: .text(.light))
            }
          }
        }
      }

      Section("Product Colors") {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
          ForEach(Color.ProductColor.allCases, id: \.self) { color in
            VStack {
              shape.foregroundColor(.product(color))
              Text(color.rawValue).pbFont(.caption, color: .text(.light))
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
#endif
