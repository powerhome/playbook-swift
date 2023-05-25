//
//  PBMultipleUsersStacked.swift
//
//
//  Created by Alexandre Hauber on 22/07/21.
//

import SwiftUI

public struct PBMultipleUsersStacked: View {
  var users: [PBUser]
  var size: Size

  public init(users: [PBUser], size: Size = .xSmall) {
    self.users = users
    self.size = size
  }

  public var body: some View {
    if users.count == 1 {
      PBAvatar(image: users[0].image, name: users[0].name, size: avatarSize)
    } else if users.count >= 2 {
      ZStack {
        PBAvatar(image: users[0].image, name: users[0].name, size: stackedSize.0)
        if users.count == 2 {
          PBAvatar(image: users[1].image, name: users[1].name, size: stackedSize.1, wrapped: true)
            .offset(x: offsetSize, y: offsetSize)
        } else {
          PBMultipleUsersIndicator(usersCount: users.count - 1, size: stackedSize.1)
            .offset(x: offsetSize, y: offsetSize)
        }
      }
    }
  }

  var avatarSize: PBAvatar.Size {
    switch size {
    case .small: return .small
    case .xSmall: return .xSmall
    case .default: return .defaultStackedIndicator
    }
  }

  var stackedSize: (PBAvatar.Size, PBAvatar.Size) {
    switch size {
    case .small: return (PBAvatar.Size.defaultStacked, PBAvatar.Size.defaultStackedIndicator)
    case .xSmall: return (PBAvatar.Size.smallStacked, PBAvatar.Size.smallStackedIndicator)
    case .default: return (PBAvatar.Size.defaultStackedIndicator, PBAvatar.Size.defaultStackedIndicator)
    }
  }

  var offsetSize: CGFloat {
    switch size {
    case .small: return 12
    case .xSmall: return 9
    case .default: return 9
    }
  }
}
public extension PBMultipleUsersStacked {
  enum Size {
    case small, xSmall, `default`
  }
}

public struct PBMultipleUsersStacked_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()

    let andrew = PBUser(name: "Andrew Black")
    let picAndrew = PBUser(name: "Andrew Black", image: Image("andrew", bundle: .module))
    let oneUser = [andrew]
    let twoUsers = [andrew, picAndrew]
    let multipleUsers = [andrew, picAndrew, andrew, andrew]

    return List {
      VStack(alignment: .leading, spacing: 15) {

        HStack(alignment: .top) {
          PBMultipleUsersStacked(users: oneUser, size: .small)
          PBMultipleUsersStacked(users: twoUsers, size: .small)
          PBMultipleUsersStacked(users: multipleUsers, size: .small)
        }

        VStack(alignment: .leading, spacing: 15) {
          PBMultipleUsersStacked(users: oneUser, size: .small)
          PBMultipleUsersStacked(users: twoUsers, size: .small)
          PBMultipleUsersStacked(users: multipleUsers, size: .small)
        }
      }

      VStack(alignment: .leading, spacing: 15) {

        HStack(alignment: .top) {
          PBMultipleUsersStacked(users: oneUser, size: .xSmall)
          PBMultipleUsersStacked(users: twoUsers, size: .xSmall)
          PBMultipleUsersStacked(users: multipleUsers, size: .xSmall)
        }
  

        VStack(alignment: .leading, spacing: 15) {
          PBMultipleUsersStacked(users: oneUser, size: .xSmall)
          PBMultipleUsersStacked(users: twoUsers, size: .xSmall)
          PBMultipleUsersStacked(users: multipleUsers, size: .xSmall)
        }
       
      }
      
      
      VStack(alignment: .leading, spacing: 15) {

        HStack(alignment: .top) {
          PBMultipleUsersStacked(users: oneUser, size: .xSmall)
          PBMultipleUsersStacked(users: twoUsers, size: .default)
          PBMultipleUsersStacked(users: multipleUsers, size: .default)
        }


        VStack(alignment: .leading, spacing: 15) {
          PBMultipleUsersStacked(users: oneUser, size: .xSmall)
          PBMultipleUsersStacked(users: twoUsers, size: .default)
         
          HStack {
            PBMultipleUsersStacked(users: multipleUsers, size: .default)
            PBMultipleUsersStacked(users: multipleUsers, size: .default)
          }
        }
        
      }
      
    }
  }
}
