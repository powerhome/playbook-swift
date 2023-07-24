//
//  Typography.swift
//
//
//  Created by Lucas C. Feijo on 14/07/21.
//

import SwiftUI

public struct Typography: ViewModifier {
  var font: PBFont
  var variant: Variant
  var letterSpace: LetterSpacing?
  var color: Color?

  var foregroundColor: Color {
    if let color = color {
      return color
    } else {
      if variant == .link {
        return .pbPrimary
      } else {
        if font == .caption || font == .largeCaption || font == .subcaption {
          return .text(.light)
        } else {
          return .text(.default)
        }
      }
    }
  }

  var spacing: CGFloat {
    switch font {
    case .title1: return 4.6
    case .title2: return 3.4
    case .title3: return 2.8
    case .title4, .body: return 1.6
    default: return 0
    }
  }

  var casing: Text.Case? {
    switch font {
    case .largeCaption, .caption: return .uppercase
    default: return nil
    }
  }

  var letterSpacing: CGFloat {
    if let space = letterSpace {
      return space.rawValue
    } else {
      switch font {
      case .caption, .largeCaption: return LetterSpacing.looser.rawValue
      case .title4: return LetterSpacing.tight.rawValue
      default: return LetterSpacing.normal.rawValue
      }
    }
  }

  var fontWeight: Font.Weight {
    switch font {
    case .title1, .title2: return variant == .light ? FontWeight.light : FontWeight.bolder
    case .title3: return FontWeight.light
    case .title4, .buttonText, .badgeText: return FontWeight.bolder
    case .caption: return FontWeight.bold
    default: return FontWeight.regular
    }
  }

  public func body(content: Content) -> some View {
    if #available(iOS 16.0, *) {
      content
        .font(font.font)
        .tracking(letterSpacing)
        .fontWeight(fontWeight)
        .lineSpacing(spacing)
        .textCase(casing)
        .foregroundColor(foregroundColor)
    } else {
      content
        .font(font.font)
        .lineSpacing(spacing)
        .textCase(casing)
        .foregroundColor(foregroundColor)
    }
  }
}

public extension Typography {
  enum Variant {
    case none
    case link
    case bold
    case light
  }

  enum LetterSpacing: CGFloat, CaseIterable {
    case tightest = -1.6
    case tighter = -1.12
    case tight = -0.48
    case normal = 0
    case loose = 0.48
    case looser = 1.12
    case loosest = 1.6
    case superLoosest = 3.2
  }
}

public extension View {
  func pbFont(
    _ font: PBFont,
    variant: Typography.Variant = .none,
    letterSpace: Typography.LetterSpacing? = nil,
    color: Color? = nil
  ) -> some View {
    self.modifier(
      Typography(
        font: font,
        variant: variant,
        letterSpace: letterSpace,
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
