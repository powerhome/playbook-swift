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

  static let avatarXSmall = PBAvatar(image: Image("andrew", bundle: .module), size: .xSmall)
  static let avatarXSmallStatus = PBAvatar(image: Image("andrew", bundle: .module), size: .xSmall, status: .online)
  static let userName = "Andrew Black"
  static let message: AttributedString = "How can we assist you today?"
  static let timestamp =  PBTimestamp(Date(), showDate: false)
  static let picAnna = PBAvatar(image: Image("Anna", bundle: .module), size: .xSmall, status: .online)
  static let picPatric = PBAvatar(image: Image("Pat", bundle: .module), size: .xSmall)
  static let picLuccile = PBAvatar(image: Image("Lu", bundle: .module), size: .xSmall)
    static let assetsColors: [PBTypeahead.Option] = [
    .init(id: "1", text: "Orange", customView: nil),
    .init(id: "2", text: "Red", customView: nil),
    .init(id: "3", text: "Blue", customView: nil),
    .init(id: "4", text: "Pink", customView: nil),
    .init(id: "5", text: "Magenta", customView: nil)
  ]
    static let assetesMultipleUsers: [PBTypeahead.Option] = [
        .init(id: "1", text: andrew.name, customView: { AnyView(andrew) }),
        .init(id: "2", text: ana.name, customView: { AnyView(ana) }),
        .init(id: "3", text: patric.name, customView: { AnyView(patric) }),
        .init(id: "4", text: luccile.name, customView: { AnyView(luccile) })
    ]

    static let assetsSectionUsers: [PBTypeahead.OptionType] = [
        .section("section 1"),
        .item(.init(id: "1", text: andrew.name, customView: { AnyView(andrew) })),
        .item(.init(id: "2", text: ana.name, customView: { AnyView(ana) })),
//        .item(.init(id: "3", text: patric.name, customView: { AnyView(patric) })),
//        .item(.init(id: "4", text: luccile.name, customView: { AnyView(luccile) })),
//        .button(PBButton(variant: .link, title: "view more")),
        .section("section 2"),
        .item(.init(id: "5", text: andrew.name, customView: { AnyView(andrew) })),
//        .item(.init(id: "6", text: ana.name, customView: { AnyView(ana) })),
//        .item(.init(id: "7", text: patric.name, customView: { AnyView(patric) })),
        .item(.init(id: "8", text: luccile.name, customView: { AnyView(luccile) }))
//        .button(PBButton(variant: .primary, title: "view more"))
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

  static let spaceImages: [Image] = [
    Image(.space1),
    Image(.space2),
    Image(.space3),
    Image(.space4),
    Image(.space5),
    Image(.space6),
    Image(.space7),
    Image(.space8),
    Image(.space9),
    Image(.space10),
    Image(.space11),
    Image(.space12),
    Image(.space13),
    Image(.space14),
    Image(.space15),
    Image(.space16),
    Image(.space17)
  ]
}
