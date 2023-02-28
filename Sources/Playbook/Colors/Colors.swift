//
//  Colors.swift
//  
//
//  Created by Lucas C. Feijo on 12/07/21.
//

import SwiftUI

public extension Color {
  static let pbPrimary = Color("Primary", bundle: .module)
  static let card = Color("Card", bundle: .module)
  static let active = Color("Active", bundle: .module)
  static let border = Color("Border", bundle: .module)
  static let shadow = Color("Shadow", bundle: .module)
  static let hover = Color("Hover", bundle: .module)

  var subtle: Color {
    self.opacity(0.1)
  }

  static func text(_ variant: TextColor) -> Color {
    switch variant {
    case .textDefault: return Color("TextDefault", bundle: .module)
    case .light: return Color("TextLight", bundle: .module)
    case .lighter: return Color("TextLighter", bundle: .module)
    case .white: return Color.white
    }
  }

  static func background(_ variant: BackgroundColor) -> Color {
    switch variant {
    case .light: return Color("BackgroundLight", bundle: .module)
    case .white: return Color("BackgroundWhite", bundle: .module)
    case .dark: return Color("BackgroundDark", bundle: .module)
    case .`default`: return Color("Background", bundle: .module)
    }
  }

  static func status(_ variant: StatusColor, subtle: Bool = false) -> Color {
    switch variant {
    case .success: return Color("Success", bundle: .module).opacity(subtle ? 0.1 : 1)
    case .warning: return Color("Warning", bundle: .module).opacity(subtle ? 0.1 : 1)
    case .error: return Color("Error", bundle: .module).opacity(subtle ? 0.1 : 1)
    case .info: return Color("Info", bundle: .module).opacity(subtle ? 0.1 : 1)
    case .neutral: return Color("Neutral", bundle: .module).opacity(subtle ? 0.1 : 1)
    case .primary: return Color("Primary", bundle: .module)
    }
  }

  static func data(_ variant: DataColor) -> Color {
    switch variant {
    case .data1: return Color("Data1", bundle: .module)
    case .data2: return Color("Data2", bundle: .module)
    case .data3: return Color("Data3", bundle: .module)
    case .data4: return Color("Data4", bundle: .module)
    case .data5: return Color("Data5", bundle: .module)
    case .data6: return Color("Data6", bundle: .module)
    case .data7: return Color("Data7", bundle: .module)
    case .data8: return Color("Data8", bundle: .module)
    }
  }

  static func product(_ variant: ProductColor) -> Color {
    switch variant {
    case .windows: return Color("Windows", bundle: .module)
    case .siding: return Color("Siding", bundle: .module)
    case .doors: return Color("Doors", bundle: .module)
    case .solar: return Color("Solar", bundle: .module)
    case .roofing: return Color("Roofing", bundle: .module)
    case .gutters: return Color("Gutters", bundle: .module)
    case .insulation: return Color("Insulation", bundle: .module)
    }
  }

  static func category(_ variant: CategoryColor) -> Color {
    switch variant {
    case .category1: return Color("Category1", bundle: .module)
    case .category2: return Color("Category2", bundle: .module)
    case .category3: return Color("Category3", bundle: .module)
    case .category4: return Color("Category4", bundle: .module)
    case .category5: return Color("Category5", bundle: .module)
    case .category6: return Color("Category6", bundle: .module)
    case .category7: return Color("Category7", bundle: .module)
    case .category8: return Color("Category8", bundle: .module)
    case .category9: return Color("Category9", bundle: .module)
    case .category10: return Color("Category10", bundle: .module)
    case .category11: return Color("Category11", bundle: .module)
    case .category12: return Color("Category12", bundle: .module)
    case .category13: return Color("Category13", bundle: .module)
    case .category14: return Color("Category14", bundle: .module)
    case .category15: return Color("Category15", bundle: .module)
    case .category16: return Color("Category16", bundle: .module)
    case .category17: return Color("Category17", bundle: .module)
    case .category18: return Color("Category18", bundle: .module)
    case .category19: return Color("Category19", bundle: .module)
    case .category20: return Color("Category20", bundle: .module)
    case .category21: return Color("Category21", bundle: .module)
    }
  }
}

public extension Color {
  enum TextColor: String, CaseIterable {
    case textDefault, light, lighter, white
  }

  enum BackgroundColor: String, CaseIterable {
    case `default`, light, dark, white
  }

  enum StatusColor: String, CaseIterable {
    case success, warning, error, info, neutral, primary
  }

  enum DataColor: String, CaseIterable {
    case data1, data2, data3, data4, data5, data6, data7, data8
  }

  enum ProductColor: String, CaseIterable {
    case windows, siding, doors, solar, roofing, gutters, insulation
  }

  enum CategoryColor {
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
  // TODO: - Add this colors in playbook kit or change connect design to use playbook colors
  static let pbMention         = Color("Mention", bundle: .module)
  static let pbMentionMe       = Color("MentionMe", bundle: .module)
  static let pbMentionText     = Color("MentionText", bundle: .module)

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
