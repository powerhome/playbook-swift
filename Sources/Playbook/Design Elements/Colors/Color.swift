//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Color.swift
//

import SwiftUI

public extension Color {
  static let pbPrimary = Color("Primary")
  static let card = Color("Card")
  static let active = Color("Active")
  static let border = Color("Border")
  static let focus = Color("Focus")
  static let shadow = Color("Shadow")
  static let hover = Color("Hover")

  static func text(_ variant: TextColor) -> Color {
    switch variant {
    case .default: return Color("TextDefault")
    case .light: return Color("TextLight")
    case .lighter: return Color("TextLighter")
    case .successSmall: return Color("SuccessSmall")
    case .warningText: return Color(hex: "#C69500")
    }
  }

  static func background(_ variant: BackgroundColor) -> Color {
    switch variant {
    case .light: return Color("BackgroundLight")
    case .dark: return Color("BackgroundDark")
    case .default: return Color("BackgroundDefault")
    }
  }

  static func status(_ variant: StatusColor, subtle: Bool = false) -> Color {
    switch variant {
    case .success: return Color("Success").opacity(subtle ? 0.1 : 1)
    case .warning: return Color("Warning").opacity(subtle ? 0.1 : 1)
    case .error: return Color("Error").opacity(subtle ? 0.1 : 1)
    case .info: return Color("Info").opacity(subtle ? 0.1 : 1)
    case .neutral: return Color("Neutral").opacity(subtle ? 0.1 : 1)
    case .primary: return Color("Primary").opacity(subtle ? 0.1 : 1)
    }
  }

  static func data(_ variant: DataColor) -> Color {
    switch variant {
    case .data1: return Color("Data1")
    case .data2: return Color("Data2")
    case .data3: return Color("Data3")
    case .data4: return Color("Data4")
    case .data5: return Color("Data5")
    case .data6: return Color("Data6")
    case .data7: return Color("Data7")
    case .data8: return Color("Data8")
    }
  }

  static func product(_ variant: ProductColor, category: ProductColor.Category) -> Color {
    let productCategory = category == .background ? "Background" : "Highlight"
    switch variant {
    case .product1: return Color("Product1" + productCategory)
    case .product2: return Color("Product2" + productCategory)
    case .product3: return Color("Product3" + productCategory)
    case .product4: return Color("Product4" + productCategory)
    case .product5: return Color("Product5" + productCategory)
    case .product6: return Color("Product6" + productCategory)
    case .product7: return Color("Product7" + productCategory)
    case .product8: return Color("Product8" + productCategory)
    case .product9: return Color("Product9" + productCategory)
    case .product10: return Color("Product10" + productCategory)
    }
  }

  static func category(_ variant: CategoryColor) -> Color {
    switch variant {
    case .category1: return Color("Category1")
    case .category2: return Color("Category2")
    case .category3: return Color("Category3")
    case .category4: return Color("Category4")
    case .category5: return Color("Category5")
    case .category6: return Color("Category6")
    case .category7: return Color("Category7")
    case .category8: return Color("Category8")
    case .category9: return Color("Category9")
    case .category10: return Color("Category10")
    case .category11: return Color("Category11")
    case .category12: return Color("Category12")
    case .category13: return Color("Category13")
    case .category14: return Color("Category14")
    case .category15: return Color("Category15")
    case .category16: return Color("Category16")
    case .category17: return Color("Category17")
    case .category18: return Color("Category18")
    case .category19: return Color("Category19")
    case .category20: return Color("Category20")
    case .category21: return Color("Category21")
    }
  }
}

public extension Color {
  enum TextColor: String, CaseIterable {
    case `default`, light, lighter, successSmall, warningText
  }

  enum BackgroundColor: String, CaseIterable {
    case `default`, light, dark
  }

  enum StatusColor: String, CaseIterable {
    case success, warning, error, info, neutral, primary
  }

  enum DataColor: String, CaseIterable {
    case data1, data2, data3, data4, data5, data6, data7, data8
  }

  enum ProductColor: String, CaseIterable, Hashable {
    case product1
    case product2
    case product3
    case product4
    case product5
    case product6
    case product7
    case product8
    case product9
    case product10

    public enum Category {
      case highlight, background
    }
  }

  enum CategoryColor: String, CaseIterable {
    case category1
    case category2
    case category3
    case category4
    case category5
    case category6
    case category7
    case category8
    case category9
    case category10
    case category11
    case category12
    case category13
    case category14
    case category15
    case category16
    case category17
    case category18
    case category19
    case category20
    case category21
  }
}

public extension Color {
  enum Buttons {
    enum Secondary {
      static func background(_ colorScheme: ColorScheme) -> Color {
        return colorScheme == .light ? .pbPrimary.opacity(0.05) : Color(hex: "#fff").opacity(0.2)
      }
      static func foreground(_ colorScheme: ColorScheme) -> Color {
        return colorScheme == .light ? .pbPrimary : .white
      }
    }
  }
  
  enum Card {
    static func background(_ colorScheme: ColorScheme) -> Color {
      return colorScheme == .light ? .card : Color(red: 35/255, green: 30/255, blue: 61/255)
    }
    static func foreground(_ colorScheme: ColorScheme) -> Color {
      return colorScheme == .light ? .pbPrimary : .white
    }
  }
  
  enum BorderColor {
    static func borderColor(_ colorScheme: ColorScheme) -> Color {
      return colorScheme == .light ? .white : Color(hex: "#3b3752")
    }
  }
}

public extension Color {
  init(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)
    let a, r, g, b: UInt64
    switch hex.count {
      case 3: // RGB (12-bit)
        (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
      case 6: // RGB (24-bit)
        (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
      case 8: // ARGB (32-bit)
        (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
      default:
        (a, r, g, b) = (1, 1, 1, 0)
    }
    
    self.init(
      .sRGB,
      red: Double(r) / 255,
      green: Double(g) / 255,
      blue: Double(b) / 255,
      opacity: Double(a) / 255
    )
  }
  
  init(hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xff) / 255,
      green: Double((hex >> 08) & 0xff) / 255,
      blue: Double((hex >> 00) & 0xff) / 255,
      opacity: alpha
    )
  }
}
