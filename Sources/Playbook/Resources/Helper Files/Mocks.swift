//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Mocks.swift
//


import SwiftUI

enum Mocks {
    static let andrew = PBUser(name: "Andrew Black", nameFont: .init(font: .title4, variant: .bold), image: Image("andrew", bundle: .module), size: .small, title: "Senior User Experience Engineer")
  static let ana = PBUser(name: "Ana Black", nameFont: .init(font: .title4, variant: .bold), image: Image("Anna", bundle: .module), size: .small, title: "Senior User Experience Engineer")
  static let patric = PBUser(name: "Pat Black", nameFont: .init(font: .title4, variant: .bold), image: Image("Pat", bundle: .module), size: .small, title: "Senior User Experience Engineer")
  static let luccile = PBUser(name: "Luccile Black", nameFont: .init(font: .title4, variant: .bold), image: Image("Lu", bundle: .module), size: .small, title: "Senior User Experience Engineer")
  static let oneUser = [andrew]
  static let twoUsers = [andrew, ana]
  static let threeUsers = [andrew, ana, patric]
  static let multipleUsers = [andrew, ana, patric, luccile]
    static let multipleUsersDictionary: [(String, PBUser?)] = [(andrew.name, andrew), (ana.name, ana), (patric.name, patric), (luccile.name, luccile)]
  static let avatarXSmall = PBAvatar(image: Image("andrew", bundle: .module), size: .xSmall)
  static let avatarXSmallStatus = PBAvatar(image: Image("andrew", bundle: .module), size: .xSmall, status: .online)
  static let userName = "Andrew Black"
  static let message: AttributedString = "How can we assist you today?"
  static let timestamp =  PBTimestamp(Date(), showDate: false)
  static let picAnna = PBAvatar(image: Image("Anna", bundle: .module), size: .xSmall, status: .online)
  static let picPatric = PBAvatar(image: Image("Pat", bundle: .module), size: .xSmall)
  static let picLuccile = PBAvatar(image: Image("Lu", bundle: .module), size: .xSmall)
  static let assetsColors: [(String, AnyView?)] = [
    ("Orange", nil),
    ("Red", nil),
    ("Green", nil),
    ("Blue", nil),
    ("Pink", nil),
    ("Yellow", nil),
    ("Violet", nil),
    ("Indigo", nil),
    ("Magenta", nil)
  ]
  static let cities: [String] = [
    "Philadelphia",
    "New York",
    "Chicago",
    "Los Angeles",
    "San Francisco",
    "Boston",
    "Miami",
    "Seattle",
    "Dallas"
  
  ]
}
