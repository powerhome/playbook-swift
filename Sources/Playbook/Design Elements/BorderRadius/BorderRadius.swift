//
//  BorderRadius.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import Foundation

public struct BorderRadius {
  public static let none: CGFloat = 0
  public static let xSmall: CGFloat = 2
  public static let small: CGFloat = 4
  public static let medium: CGFloat = 6
  public static let large: CGFloat = 8
  public static let xLarge: CGFloat = 16
  public static let rounded: CGFloat = 48

  public static let allCase = [
    (BorderRadius.none, "None"),
    (BorderRadius.xSmall, "X Small"),
    (BorderRadius.small, "Small"),
    (BorderRadius.medium, "Medium"),
    (BorderRadius.large, "Large"),
    (BorderRadius.xLarge, "X Large"),
    (BorderRadius.rounded, "Rounded")
  ]
}
