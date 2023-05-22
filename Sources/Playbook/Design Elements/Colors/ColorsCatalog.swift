///
//  ColorsCatalog.swift
//
//
//  Created by Isis Silva on 4/18/23.
//

import SwiftUI

public struct ColorsCatalog: View {

  public init() {}

  public var body: some View {
    let shape = Circle().frame(width: 60).pbShadow(.deep)
    List {
      Section("Text") {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
          ForEach(Color.TextColor.allCases, id: \.self) { color in
            VStack {
              shape.foregroundColor(Color.text(color))
              Text(color.rawValue.capitalized).pbFont(.subcaption, color: .text(.light))
            }
          }
        }
      }

      Section("Background") {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
          ForEach(Color.BackgroundColor.allCases, id: \.self) { color in
            VStack {
              shape.foregroundColor(.background(color))
              Text(color.rawValue.capitalized).pbFont(.subcaption, color: .text(.light))
            }
          }
        }
      }

      Section("Status") {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
          ForEach(Color.StatusColor.allCases, id: \.self) { color in
            VStack {
              shape.foregroundColor(.status(color))
              Text(color.rawValue).pbFont(.subcaption, color: .text(.light))
            }
          }
        }
      }

      Section("Status Subtle") {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
          ForEach(Color.StatusColor.allCases, id: \.self) { color in
            VStack {
              shape.foregroundColor(Color.status(color, subtle: true))
              Text(color.rawValue).pbFont(.subcaption, color: .text(.light))
            }
          }
        }
      }

      Section("Product Background") {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
          ForEach(Color.ProductColor.allCases, id: \.self) { color in
            VStack {
              shape.foregroundColor(.product(color, category: .background))
              Text(color.rawValue.capitalized).pbFont(.subcaption, color: .text(.light))
            }
          }
        }
      }

      Section("Product Highlight") {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
          ForEach(Color.ProductColor.allCases, id: \.self) { color in
            VStack {
              shape.foregroundColor(.product(color, category: .highlight))
              Text(color.rawValue.capitalized).pbFont(.subcaption, color: .text(.light))
            }
          }
        }
      }

      //      Section("Category") {
      //        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
      //          ForEach(Color.CategoryColor.allCases, id: \.self) { color in
      //            VStack {
      //              shape.foregroundColor(.category(color))
      //              Text(color.rawValue.capitalized).pbFont(.subcaption, color: .text(.light))
      //            }
      //          }
      //        }
      //      }
    }
    .navigationTitle("Colors")
  }
}
