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
    case body(_ size: TextSize? = .base)
    case buttonText(_ size: CGFloat = PBButtonSize.medium.fontSize)
    case largeCaption
    case caption
    case subcaption
    case monogram(_ size: CGFloat)
    case badgeText
    
    var font: Font {
        switch self {
        case .title1:
            return Font.custom(ProximaNova.light.rawValue, size: 48, relativeTo: .largeTitle)
        case .title2:
            return Font.custom(ProximaNova.light.rawValue, size: 34, relativeTo: .title)
        case .title3:
            return Font.custom(ProximaNova.light.rawValue, size: TextSize.larger.rawValue, relativeTo: .title2)
        case .title4:
            return Font.custom(ProximaNova.bold.rawValue, size: TextSize.base.rawValue, relativeTo: .title3)
        case .body(let size):
            return Font.custom(ProximaNova.light.rawValue, size: size?.rawValue ?? TextSize.base.rawValue, relativeTo: .body)
        case .buttonText(let size):
            return Font.custom(ProximaNova.bold.rawValue, size: size, relativeTo: .body)
        case .largeCaption:
            return Font.custom(ProximaNova.regular.rawValue, size: TextSize.small.rawValue, relativeTo: .caption)
        case .caption:
            return Font.custom(ProximaNova.semibold.rawValue, size: TextSize.smaller.rawValue, relativeTo: .caption2)
        case .subcaption:
            return Font.custom(ProximaNova.regular.rawValue, size: TextSize.smaller.rawValue, relativeTo: .caption2)
        case .monogram(let size):
            return Font.custom(ProximaNova.light.rawValue, size: size, relativeTo: .body)
        case .badgeText:
            return Font.custom(ProximaNova.bold.rawValue, size: TextSize.smallest.rawValue, relativeTo: .body)
        }
    }
}

public enum TextSize: CGFloat, CaseIterable {
    case smallest = 11
    case smaller = 12
    case small = 14
    case base = 16
    case large = 20
    case larger = 28
    case largest = 32
    case jumbo = 36
}
