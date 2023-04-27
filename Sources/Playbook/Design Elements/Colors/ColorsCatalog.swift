//
//  ColorsCatalog.swift
//  
//
//  Created by Isis Silva on 4/18/23.
//

import SwiftUI

struct ColorsCatalog: View {
  var body: some View {
    let shape = Circle().frame(width: 60).pbShadow(.deep)
    List {
      Section("Text") {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
          ForEach(Color.TextColor.allCases, id: \.self) { color in
            VStack {
              shape.foregroundColor(Color.text(color))
              Text(color.rawValue.uppercased()).pbFont(.caption, color: .text(.light))
            }
          }
        }
      }

      Section("Background") {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
          ForEach(Color.BackgroundColor.allCases, id: \.self) { color in
            VStack {
              shape.foregroundColor(.background(color))
              Text(color.rawValue).pbFont(.caption, color: .text(.light))
            }
          }
        }
      }

      Section("Status") {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
          ForEach(Color.StatusColor.allCases, id: \.self) { color in
            VStack {
              shape.foregroundColor(.status(color))
              Text(color.rawValue).pbFont(.caption, color: .text(.light))
            }
          }
        }
      }

      Section("Product Highlight") {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
          ForEach(Color.ProductColor.allCases, id: \.self) { color in
            VStack {
              shape.foregroundColor(.product(color, category: .highlight))
              Text(color.rawValue.uppercased()).pbFont(.body(.smallest), color: .text(.light))
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
