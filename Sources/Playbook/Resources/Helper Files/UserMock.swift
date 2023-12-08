//
//  File.swift
//  
//
//  Created by Isis Silva on 26/05/23.
//

import SwiftUI

enum Mocks {
  static let andrew = PBUser(name: "Andrew Black", image: Image("andrew", bundle: .module))
  static let ana = PBUser(name: "Andrew Black", image: Image("Anna", bundle: .module))
  static let patric = PBUser(name: "Andrew Black", image: Image("Pat", bundle: .module))
  static let luccile = PBUser(name: "Andrew Black", image: Image("andrew", bundle: .module))
  static let oneUser = [andrew]
  static let twoUsers = [andrew, ana]
  static let multipleUsers = [andrew, ana, patric, luccile]
  static let multipleUsersDictionary: [String : PBUser] = ["Andrew" : andrew, "Ana" : ana, "Patric" : patric, "Luccile" : andrew]
  static let avatarXSmall = PBAvatar(image: Image("andrew", bundle: .module), size: .xSmall)
  static let avatarXSmallStatus = PBAvatar(image: Image("andrew", bundle: .module), size: .xSmall, status: .online)
  static let userName = "Andrew Black"
  static let message = "How can we assist you today?"
  static let timestamp =  PBTimestamp(Date(), showDate: false)
  static let picAnna = PBAvatar(image: Image("Anna", bundle: .module), size: .xSmall, status: .online)
  static let picPatric = PBAvatar(image: Image("Pat", bundle: .module), size: .xSmall)
  static let picLuccile = PBAvatar(image: Image("Lu", bundle: .module), size: .xSmall)
}
