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
  var weight: Font.Weight
  var color: Color

  var foregroundColor: Color {
    switch variant {
    case .link:
      return .pbPrimary
    default: return color
    }
  }

  var spacing: CGFloat {
    switch font {
    case .title1: return 3
    case .title2: return -1
    case .title3, .title4: return 2
    case .body, .badgeText: return 0
    case .monogram: return 2.5
    default: return 6
    }
  }

  var casing: Text.Case? {
    switch font {
    case .largeCaption, .caption: return .uppercase
    default: return nil
    }
  }

  var kerning: CGFloat {
    switch font {
    case .caption, .largeCaption: return 1.2
    case .title4: return -0.3
    default: return 0
    }
  }

  public func body(content: Content) -> some View {
    if #available(iOS 16.0, *) {
      content
        .font(font.font)
        .kerning(kerning)
        .lineSpacing(spacing)
        .padding(.vertical, spacing)
        .textCase(casing)
        .foregroundColor(foregroundColor)
    } else {
      content
        .font(font.font)
        .lineSpacing(spacing)
        .padding(.vertical, spacing)
        .textCase(casing)
        .foregroundColor(foregroundColor)
    }
  }
}

public extension Typography {
  enum Variant {
    case none
    case link
  }
}

public extension View {
  func pbFont(
    _ font: PBFont,
    variant: Typography.Variant = .none,
    weight: Font.Weight = .regular,
    color: Color = .text(.default)
  ) -> some View {
    self.modifier(Typography(font: font, variant: variant, weight: weight, color: color))
  }
}

public struct Typography_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return TypographyCatalog()
  }
}
