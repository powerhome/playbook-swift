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
