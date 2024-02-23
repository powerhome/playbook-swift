//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBMultipleUsersStacked.swift
//

import SwiftUI

public struct PBMultipleUsersStacked: View {
  var users: [PBUser]
  var size: Size

  public init(
    users: [PBUser] = [],
    size: Size = .small
  ) {
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
      .frame(maxWidth: avatarSize.diameter, alignment: .leading)
      .frame(maxHeight: avatarSize.diameter, alignment: .top)
    }
  }
}

public extension PBMultipleUsersStacked {
  enum Size {
    case small, xSmall, `default`
  }

  var avatarSize: PBAvatar.Size {
    switch size {
    case .small: return .small
    case .xSmall: return .xSmall
    case .default: return .xSmall
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
    case .default: return 10
    }
  }
}

public struct PBMultipleUsersStacked_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return MultipleUsersStackedCatalog()
  }
}
