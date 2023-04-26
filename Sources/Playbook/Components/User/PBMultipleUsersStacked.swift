//
//  PBMultipleUsersStacked.swift
//
//
//  Created by Alexandre Hauber on 22/07/21.
//

import SwiftUI

public struct PBMultipleUsersStacked: View {
  var users: [PBUser]

  public init(users: [PBUser]) {
    self.users = users
  }

  public var body: some View {
    if users.count == 1 {
      PBAvatar(image: users[0].image, name: users[0].name, size: .xSmall)
    } else if users.count >= 2 {
      ZStack {
        PBAvatar(image: users[0].image, name: users[0].name, size: .xxSmall)
        if users.count == 2 {
          PBAvatar(image: users[1].image, name: users[1].name, size: .xxSmall, wrapped: true)
            .offset(x: 10, y: 10)
        } else {
          PBMultipleUsersIndicator(usersCount: users.count - 1, size: .xxSmall)
            .offset(x: 10, y: 10)
        }
      }
      .offset(x: -4)
    }
  }
}

struct PBMultipleUsersStacked_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    let andrew = PBUser(name: "Andrew Kloecker")
    let picAndrew = PBUser(name: "Andrew Kloecker", image: Image("andrew", bundle: .module))
    let oneUser = [andrew]
    let twoUsers = [andrew, picAndrew]
    let multipleUsers = [andrew, picAndrew, andrew, andrew]

    return VStack {
      PBMultipleUsersStacked(users: oneUser)
      PBMultipleUsersStacked(users: twoUsers).padding(4)
      PBMultipleUsersStacked(users: multipleUsers).padding(4)
    }
  }
}
