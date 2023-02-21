//
//  PBColor.swift
//  
//
//  Created by Lucas C. Feijo on 12/07/21.
//

import SwiftUI

public enum PBColor: Hashable {
  case primary
  case neutral
  case text(_ variant: TextColor)
  case background(_ variant: BackgroundColor)
  case card
  case status(_ variant: StatusColor)
  case data(_ variant: DataColor)
  case active
  case border
  case shadow
  case product(_ variant: ProductColor)
  case category(_ variant: CategoryColor)
  case clear

  public var color: Color {
    switch self {
    case .primary: return Color("Primary", bundle: .module)
    case .neutral: return Color("Default", bundle: .module)
    case .text(.textDefault): return Color("TextDefault", bundle: .module)
    case .text(.light): return Color("TextLight", bundle: .module)
    case .text(.lighter): return Color("TextLighter", bundle: .module)
    case .text(.white): return Color.white
    case .background(.light): return Color("BackgroundLight", bundle: .module)
    case .background(.white): return Color("BackgroundWhite", bundle: .module)
    case .background(.dark): return Color("BackgroundDark", bundle: .module)
    case .background(.gradient): return Color("BackgroundGradient", bundle: .module)
    case .card: return Color("Card", bundle: .module)
    case .status(.success): return Color("Success", bundle: .module)
    case .status(.warning): return Color("Warning", bundle: .module)
    case .status(.error): return Color("Error", bundle: .module)
    case .status(.info): return Color("Info", bundle: .module)
    case .status(.neutral): return Color("Neutral", bundle: .module)
    case .data(.data1): return Color("Data1", bundle: .module)
    case .data(.data2): return Color("Data2", bundle: .module)
    case .data(.data3): return Color("Data3", bundle: .module)
    case .data(.data4): return Color("Data4", bundle: .module)
    case .data(.data5): return Color("Data5", bundle: .module)
    case .data(.data6): return Color("Data6", bundle: .module)
    case .data(.data7): return Color("Data7", bundle: .module)
    case .data(.data8): return Color("Data8", bundle: .module)
    case .active: return Color("Active", bundle: .module)
    case .border: return Color("Border", bundle: .module)
    case .shadow: return Color("Shadow", bundle: .module)
    case .product(.windows): return Color("Windows", bundle: .module)
    case .product(.siding): return Color("Siding", bundle: .module)
    case .product(.doors): return Color("Doors", bundle: .module)
    case .product(.solar): return Color("Solar", bundle: .module)
    case .product(.roofing): return Color("Roofing", bundle: .module)
    case .product(.gutters): return Color("Gutters", bundle: .module)
    case .product(.insulation): return Color("Insulation", bundle: .module)
    case .category(.category1): return Color("Category1", bundle: .module)
    case .category(.category2): return Color("Category2", bundle: .module)
    case .category(.category3): return Color("Category3", bundle: .module)
    case .category(.category4): return Color("Category4", bundle: .module)
    case .category(.category5): return Color("Category5", bundle: .module)
    case .category(.category6): return Color("Category6", bundle: .module)
    case .category(.category7): return Color("Category7", bundle: .module)
    case .category(.category8): return Color("Category8", bundle: .module)
    case .category(.category9): return Color("Category9", bundle: .module)
    case .category(.category10): return Color("Category10", bundle: .module)
    case .category(.category11): return Color("Category11", bundle: .module)
    case .category(.category12): return Color("Category12", bundle: .module)
    case .category(.category13): return Color("Category13", bundle: .module)
    case .category(.category14): return Color("Category14", bundle: .module)
    case .category(.category15): return Color("Category15", bundle: .module)
    case .category(.category16): return Color("Category16", bundle: .module)
    case .category(.category17): return Color("Category17", bundle: .module)
    case .category(.category18): return Color("Category18", bundle: .module)
    case .category(.category19): return Color("Category19", bundle: .module)
    case .category(.category20): return Color("Category20", bundle: .module)
    case .category(.category21): return Color("Category21", bundle: .module)
    case .clear: return Color.clear
    }
  }
}

private struct PBForegroundColor: ViewModifier {
  var pbColor: PBColor

  func body(content: Content) -> some View {
    content.foregroundColor(pbColor.color)
  }
}

private struct PBBackgroundColor: ViewModifier {
  var pbColor: PBColor

  func body(content: Content) -> some View {
    content.background(pbColor.color)
  }
}

public extension View {
  func pbForegroundColor(_ pbColor: PBColor) -> some View {
    self.modifier(PBForegroundColor(pbColor: pbColor))
  }

  func pbBackgroundColor(_ pbColor: PBColor) -> some View {
    self.modifier(PBBackgroundColor(pbColor: pbColor))
  }
}

extension Color {
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

public extension PBColor {
  enum TextColor: String, CaseIterable {
    case textDefault, light, lighter, white
  }

  enum BackgroundColor: String, CaseIterable {
    case light, white, dark, gradient
  }

  enum StatusColor: String, CaseIterable {
    case success, warning, error, info, neutral
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

public enum StatusVariant: CaseIterable {
   case chat
   case error
   case info
   case neutral
   case primary
   case success
   case warning

  var foregroundColor: PBColor {
     switch self {
     case .chat: return .card
     case .error: return .status(.error)
     case .info: return .status(.info)
     case .neutral: return .status(.neutral)
     case .success: return .status(.success)
     case .warning: return .status(.warning)
     default: return .primary
     }
   }

  var backgroundColor: Color {
     if self == .chat {
       return PBColor.primary.color
     } else {
       return foregroundColor.color.opacity(0.12)
     }
   }
 }
