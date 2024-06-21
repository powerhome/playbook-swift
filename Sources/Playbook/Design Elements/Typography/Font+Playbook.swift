//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBFont.swift
//

import SwiftUI
import power_fonts

public enum PBFont: Equatable {
  case title1
  case title2
  case title3
  case title4
  case body
  case buttonText(_ size: CGFloat = PBButton.Size.medium.fontSize)
  case largeCaption
  case caption
  case subcaption
  case monogram(_ size: CGFloat)
  case badgeText
  case detail(_ isBold: Bool)
  case messageTitle
  case messageBody

    static let proximaNovaLight = Font.ProximaNova.light.rawValue

  var font: Font {
    switch self {
    case .title1:
      return Font.custom(
        PBFont.proximaNovaLight,
        size: size,
        relativeTo: .largeTitle
      )
    case .title2:
      return Font.custom(
        PBFont.proximaNovaLight,
        size: size,
        relativeTo: .title
      )
    case .title3:
      return Font.custom(
        PBFont.proximaNovaLight,
        size: size,
        relativeTo: .title2
      )
    case .title4:
      return Font.custom(
        Font.ProximaNova.bold.rawValue,
        size: size,
        relativeTo: .title3
      )
    case .body:
      return Font.custom(
        PBFont.proximaNovaLight,
        size: size,
        relativeTo: .body
      ).weight(Font.Weight.regular)
    case let .buttonText(fontSize):
      return Font.custom(
        Font.ProximaNova.bold.rawValue,
        size: fontSize,
        relativeTo: .body
      )
    case .largeCaption:
      return Font.custom(
        Font.ProximaNova.regular.rawValue,
        size: size,
        relativeTo: .caption2
      )
    case .caption:
      return Font.custom(
        Font.ProximaNova.semibold.rawValue,
        size: size,
        relativeTo: .caption
      )
    case .subcaption:
      return Font.custom(
        Font.ProximaNova.regular.rawValue,
        size: size
      )
    case let .monogram(fontSize):
      return Font.custom(
        PBFont.proximaNovaLight,
        size: fontSize,
        relativeTo: .body
      )
    case .badgeText:
      return Font.custom(
        Font.ProximaNova.bold.rawValue,
        size: size,
        relativeTo: .body
      )
    case .detail:
      return Font.custom(
        PBFont.proximaNovaLight,
        size: TextSize.Body.small.rawValue,
        relativeTo: .body
      )
    case .messageTitle:
      return Font.custom(
        Font.ProximaNova.bold.rawValue,
        size: size,
        relativeTo: .title3
      )
      
    case .messageBody:
      return Font.custom(
        PBFont.proximaNovaLight,
        size: size,
        relativeTo: .body
      )
    }
  }

  var size: CGFloat {
    switch self {
    case .title1: return 46
    case .title2: return 34
    case .title3: return 28
    case .title4: return 16
    case .body: return 16
    case .detail: return 14
    case .largeCaption: return 20
    case .caption: return 12
    case .subcaption: return 12
    case .monogram(let size): return size
    case .badgeText: return 11
    case .buttonText(let size): return size
    case .messageTitle: return 14
    case .messageBody: return 15
    }
  }

  func space(_ space: LetterSpacing, font: PBFont) -> CGFloat {
    switch space {
    case .tightest: return font.size * -0.1
    case .tighter: return font.size * -0.07
    case .tight: return font.size * -0.01
    case .normal: return font.size * 0
    case .loose: return font.size * 0.01
    case .looser: return font.size * 0.07
    case .loosest: return font.size * 0.1
    case .superLoosest: return font.size * 0.2
    }
  }
}

enum LetterSpacing: String, CaseIterable {
  case tightest
  case tighter
  case tight
  case normal
  case loose
  case looser
  case loosest
  case superLoosest
}

public struct FontWeight {
  static let lighter = Font.Weight.ultraLight
  static let light = Font.Weight.light
  static let regular = Font.Weight.regular
  static let bold = Font.Weight.semibold
  static let bolder = Font.Weight.bold
  static let boldest = Font.Weight.heavy
  static let extraBold = Font.Weight.black
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
