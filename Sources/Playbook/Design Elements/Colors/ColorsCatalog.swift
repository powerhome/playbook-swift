//
//  ColorsCatalog.swift
//
//
//  Created by Isis Silva on 4/18/23.
//

import SwiftUI

public struct ColorsCatalog: View {
  public var body: some View {
    let shape = Circle().frame(width: 60).pbShadow(.deep)
    let grid = [GridItem(.adaptive(minimum: 80), spacing: 16)]
    let textSection = Section("Text") {

      LazyVGrid(columns: grid) {
        ForEach(Color.TextColor.allCases, id: \.self) { color in
          VStack {
            shape.foregroundColor(Color.text(color))
            Text(color.rawValue.uppercased()).pbFont(.caption, color: .text(.light)).frame(width: 60)
          }
        }
      }
    }

    let backgroundSection = Section("Background") {
      LazyVGrid(columns: grid) {
        ForEach(Color.BackgroundColor.allCases, id: \.self) { color in
          VStack {
            shape.foregroundColor(.background(color))
            Text(color.rawValue).pbFont(.caption, color: .text(.light))
          }
        }
      }
    }

    let statusSection = Section("Status") {
      LazyVGrid(columns: grid) {
        ForEach(Color.StatusColor.allCases, id: \.self) { color in
          VStack {
            shape.foregroundColor(.status(color))
            Text(color.rawValue).pbFont(.caption, color: .text(.light))
          }
        }
      }
    }

    let productHighlightSection = Section("Product Highlight") {
      LazyVGrid(columns: grid) {
        ForEach(Color.ProductColor.allCases, id: \.self) { color in
          VStack {
            shape.foregroundColor(.product(color, category: .highlight))
            Text(color.rawValue.uppercased()).pbFont(.body(.smallest), color: .text(.light))
          }
        }
      }
    }

    let productBackgroundSection = Section("Product Background") {
      LazyVGrid(columns: grid) {
        ForEach(Color.ProductColor.allCases, id: \.self) { color in
          VStack {
            shape.foregroundColor(.product(color, category: .background))
            Text(color.rawValue.uppercased()).pbFont(.body(.smallest), color: .text(.light))
          }
        }
      }
    }

    let categorySection = Section("Category") {
      LazyVGrid(columns: grid) {
        ForEach(Color.CategoryColor.allCases, id: \.self) { color in
          VStack {
            shape.foregroundColor(.category(color))
            Text(color.rawValue.uppercased()).pbFont(.body(.smallest), color: .text(.light))
          }
        }
      }
    }

    return List {
      textSection
      backgroundSection
      statusSection
      productHighlightSection
      productBackgroundSection
      categorySection
    }
  }
}

struct ColorsCatalog_Previews: PreviewProvider {
  static var previews: some View {
    ColorsCatalog()
  }
}
