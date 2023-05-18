//
//  Spacing.swift
//
//
//  Created by Alexandre Hauber on 23/07/21.
//

import Foundation

public struct Spacing {
  public static let none: CGFloat = 0
  public static let xxSmall: CGFloat = 4
  public static let xSmall: CGFloat = 8
  public static let small: CGFloat = 16
  public static let medium: CGFloat = 24
  public static let large: CGFloat = 32
  public static let xLarge: CGFloat = 40
  
  public static let allCase = [
    (Spacing.none, "None"),
    (Spacing.xxSmall, "XX Small"),
    (Spacing.xSmall, "X Small"),
    (Spacing.small, "Small"),
    (Spacing.medium, "Medium"),
    (Spacing.large, "Large"),
    (Spacing.xLarge, "X Large")
  ]
}
