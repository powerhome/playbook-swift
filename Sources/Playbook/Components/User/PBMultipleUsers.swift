//
//  PBMultipleUsers.swift
//
//
//  Created by Alexandre Hauber on 16/07/21.
//

import SwiftUI

public struct PBMultipleUsers: View {
  var users: [PBUser]
  var size: AvatarSize
  var reversed: Bool
  var maxDisplayedUsers: Int

  public init(
    users: [PBUser],
    size: AvatarSize = .small,
    reversed: Bool = false,
    maxDisplayedUsers: Int = 4
  ) {
    self.users = users
    self.size = size
    self.reversed = reversed
    self.maxDisplayedUsers = maxDisplayedUsers
  }

  var filteredUsers: ([PBUser], Int?) {
    var displayedUsers = users
    var additionalUsers = 0

    if users.count > maxDisplayedUsers {
      displayedUsers = Array(users.prefix(maxDisplayedUsers - 1))
      additionalUsers = users.count - maxDisplayedUsers + 1
    }

    return (displayedUsers, additionalUsers)
  }

  func xOffset(index: Int) -> CGFloat {
    let offset = size.avatarSize.diameter / 1.5 * CGFloat(index)

    return reversed ? -offset : offset
  }

  var leadingPadding: CGFloat {
    let padding = size.avatarSize.diameter / 1.5 * CGFloat(filteredUsers.0.count - (filteredUsers.1 == 0 ? 1 : 0))

    return reversed ? padding : 0
  }

  public var body: some View {
    ZStack {
      ForEach(filteredUsers.0.indices, id: \.self) { index in
        PBAvatar(
          image: filteredUsers.0[index].image,
          name: filteredUsers.0[index].name,
          size: size.avatarSize,
          wrapped: true
        )
        .offset(x: xOffset(index: index), y: 0)
      }

      PBMultipleUsersIndicator(usersCount: filteredUsers.1, size: size.avatarSize)
        .offset(x: xOffset(index: filteredUsers.0.endIndex), y: 0)
    }
    .padding(.leading, leadingPadding)
  }
}

public extension PBMultipleUsers {
  enum AvatarSize {
    case xSmall
    case small

    var avatarSize: PBAvatar.Size {
      switch self {
      case .xSmall: return .xSmall
      case .small: return .small
      }
    }
  }
}

public struct PBMultipleUsers_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()

    let andrew = PBUser(name: "Andrew Black")
    let picAndrew = PBUser(name: "Andrew Black", image: Image("andrew", bundle: .module))
    let twoUsers = [andrew, picAndrew]
    let multipleUsers = [andrew, picAndrew, andrew, andrew, andrew]

    return VStack(alignment: .leading) {
      Text("xSmall").pbFont(.title4)
      PBMultipleUsers(users: twoUsers, size: .xSmall)
      Divider()
      Text("Small").pbFont(.title4)
      PBMultipleUsers(users: multipleUsers, size: .small)
      Divider()
      Text("Small Reverse").pbFont(.title4)
      PBMultipleUsers(users: multipleUsers, size: .small, reversed: true)
      PBMultipleUsers(users: twoUsers, size: .small, reversed: true)
    }
    .padding(.leading, Spacing.xxSmall)
  }
}
