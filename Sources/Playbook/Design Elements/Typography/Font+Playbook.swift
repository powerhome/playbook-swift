//
//  Fonts.swift
//
//
//  Created by Lucas C. Feijo on 14/07/21.
//

import SwiftUI

public enum PBFont: Equatable {
  case title1
  case title2
  case title3
  case title4
  case body(_ size: TextSize.Body? = .base)
  case buttonText(_ size: CGFloat = PBButtonSize.medium.fontSize)
  case largeCaption
  case caption
  case subcaption
  case monogram(_ size: CGFloat)
  case badgeText

  static let proximaNovaLight = ProximaNova.light.rawValue

  var font: Font {
    switch self {
    case .title1:
      return Font.custom(
        PBFont.proximaNovaLight,
        size: TextSize.Title.title1.rawValue,
        relativeTo: .largeTitle
      )
    case .title2:
      return Font.custom(
        PBFont.proximaNovaLight,
        size: TextSize.Title.title2.rawValue,
        relativeTo: .title
      )
    case .title3:
      return Font.custom(
        PBFont.proximaNovaLight,
        size: TextSize.Title.title3.rawValue,
        relativeTo: .title2
      )
    case .title4:
      return Font.custom(
        ProximaNova.bold.rawValue,
        size: TextSize.Title.title4.rawValue,
        relativeTo: .title3
      )
    case let .body(size):
      return Font.custom(
        PBFont.proximaNovaLight,
        size: size?.rawValue ?? TextSize.Body.base.rawValue,
        relativeTo: .body
      )
    case let .buttonText(size):
      return Font.custom(
        ProximaNova.bold.rawValue,
        size: size,
        relativeTo: .body
      )
    case .largeCaption:
      return Font.custom(
        ProximaNova.regular.rawValue,
        size: TextSize.Body.small.rawValue,
        relativeTo: .caption
      )
    case .caption:
      return Font.custom(
        ProximaNova.semibold.rawValue,
        size: TextSize.Body.smaller.rawValue,
        relativeTo: .caption2
      )
    case .subcaption:
      return Font.custom(
        ProximaNova.regular.rawValue,
        size: TextSize.Body.smaller.rawValue,
        relativeTo: .caption2
      )
    case let .monogram(size):
      return Font.custom(
        PBFont.proximaNovaLight,
        size: size,
        relativeTo: .body
      )
    case .badgeText:
      return Font.custom(
        ProximaNova.bold.rawValue,
        size: TextSize.Body.smallest.rawValue,
        relativeTo: .body
      )
    }
  }
}

public enum TextSize {
  enum Title: CGFloat, CaseIterable {
    case title1 = 46
    case title2 = 34
    case title3 = 28
    case title4 = 16
  }

  public enum Body: CGFloat, CaseIterable {
    case smallest = 11
    case smaller = 12
    case small = 14
    case base = 16
    case large = 20
    case larger = 28
    case largest = 32
    case jumbo = 36
  }
}
