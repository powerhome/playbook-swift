//
//  File.swift
//  
//
//  Created by Isis Silva on 26/05/23.
//

import SwiftUI

let andrew = PBUser(name: "Andrew Black")
let picAndrew = PBUser(name: "Andrew Black", image: Image("andrew", bundle: .module))
let oneUser = [andrew]
let twoUsers = [andrew, picAndrew]
let multipleUsers = [andrew, picAndrew, andrew, andrew]
let avatarXSmall = PBAvatar(image: Image("andrew", bundle: .module), size: .xSmall)
let avatarXSmallStatus = PBAvatar(image: Image("andrew", bundle: .module), size: .xSmall, status: .online)
let userName = "Andrew Black"
let message = "How can we assist you today?"
let timestamp =  PBTimestamp(Date(), showDate: false)
let picAnna = PBAvatar(image: Image("Anna", bundle: .module), size: .xSmall, status: .online)
let picPatric = PBAvatar(image: Image("Pat", bundle: .module), size: .xSmall)
let picLuccile = PBAvatar(image: Image("Lu", bundle: .module), size: .xSmall)
