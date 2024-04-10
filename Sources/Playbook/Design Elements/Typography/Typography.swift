//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Typography.swift
//

import SwiftUI

public struct Typography: ViewModifier {
  var font: PBFont
  var variant: Variant
  var color: Color?

  var foregroundColor: Color {
    if let color = color {
      return color
    } else {
      if variant == .link {
        return .pbPrimary
      } else {
        switch font {
        case .caption, .largeCaption, .subcaption, .detail: return .text(.light)
        default: return .text(.default)
        }
      }
    }
  }

  var spacing: CGFloat {
    switch font {
    case .title1: return 4.6
    case .title2: return -0.7
    case .title3: return 2.8
    case .title4: return 1.6
    case .body: return 3.2
    case .detail: return 2.8
    case .caption, .subcaption: return 3
    case .largeCaption: return 5
    case .messageTitle: return 1.4
    case .messageBody: return 3
    case .badgeText: return 0
    default: return 3.2
    }
  }

  var casing: Text.Case? {
    switch font {
    case .largeCaption, .caption: return .uppercase
    default: return nil
    }
  }

  var letterSpacing: CGFloat {
    switch font {
    case .subcaption: return font.space(.normal, font: .subcaption)
    case .caption: return font.space(.looser, font: .caption)
    case .largeCaption: return font.space(.looser, font: .largeCaption)
    case .body: return font.space(.normal, font: .body)
    case .badgeText: return font.space(.normal, font: .badgeText)
    case .title1: return font.space(.tight, font: .title1)
    case .title2: return font.space(.tight, font: .title2)
    case .title3: return font.space(.tight, font: .title3)
    case .title4: return TextSize.Title.title4.rawValue * -0.03
    default: return font.space(.normal, font: .body)
    }
  }

  var fontWeight: Font.Weight {
    switch font {
    case .title1, .title2, .title3: return variant == .light ? FontWeight.light : FontWeight.bolder
    case .title4, .buttonText, .badgeText, .messageTitle: return FontWeight.bolder
    case .caption: return FontWeight.bold
    case .detail(true): return FontWeight.bold
    default: return FontWeight.regular
    }
  }
  
  public func body(content: Content) -> some View {
    content
      .font(font.font)
      .tracking(letterSpacing)
      .fontWeight(fontWeight)
      .padding(.vertical, spacing)
      .textCase(casing)
      .foregroundColor(foregroundColor)
  }
}

public extension Typography {
  enum Variant {
    case none
    case link
    case bold
    case light
  }
}

public extension View {
  func pbFont(
    _ font: PBFont,
    variant: Typography.Variant = .none,
    color: Color? = nil
  ) -> some View {
    self.modifier(
      Typography(
        font: font,
        variant: variant,
        color: color
      )
    )
  }
}

public struct Typography_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return TypographyCatalog()
  }
}
