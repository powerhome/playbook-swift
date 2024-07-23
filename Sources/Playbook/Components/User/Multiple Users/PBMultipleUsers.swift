//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBMultipleUsers.swift
//

import SwiftUI

public struct PBMultipleUsers: View {
  var users: [PBUser]
  var size: PBAvatar.Size
  var variant: Variant
  var reversed: Bool
  var bubbleSize: BubbleSize
  var bubbleCount: BubbleCount
  var maxDisplayedUsers: Int
  @State private var avSize: CGFloat = 20
  public init(
    users: [PBUser] = [],
    size: PBAvatar.Size = .small,
    variant: Variant = .linear,
    reversed: Bool = false,
    bubbleSize: BubbleSize = .small,
    bubbleCount: BubbleCount = .two,
    maxDisplayedUsers: Int = 4
  ) {
    self.users = users
    self.size = size
    self.variant = variant
    self.reversed = reversed
    self.bubbleSize = bubbleSize
    self.bubbleCount = bubbleCount
    self.maxDisplayedUsers = maxDisplayedUsers

  }

  public var body: some View {
    variantView
  }
}


public extension PBMultipleUsers {
  
  enum Variant {
    case linear, bubble
  }
  @ViewBuilder
  var variantView: some View {
      switch variant {
      case .linear: multipleUsersView
      case .bubble: multipleUsersBubbleVariant
      }
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
    let offset = size.diameter / 1.5 * CGFloat(index)

    return reversed ? -offset : offset
  }

  var leadingPadding: CGFloat {
    let padding = size.diameter / 1.5 * CGFloat(filteredUsers.0.count - (filteredUsers.1 == 0 ? 1 : 0))

    return reversed ? padding : 0
  }
  
  var totalWidth: CGFloat {
    var width = size.diameter

    if filteredUsers.0.count > 1 {
      width = size.diameter / 1.5 * CGFloat(filteredUsers.0.count - 1) + size.diameter
    }

    if users.count > maxDisplayedUsers {
      width = size.diameter / 1.5 * CGFloat(maxDisplayedUsers - 1) + size.diameter
    }

    return width
  }
  
  var multipleUsersView: some View {
    ZStack {
      ForEach(filteredUsers.0.indices, id: \.self) { index in
        PBAvatar(
          image: filteredUsers.0[index].image,
          name: filteredUsers.0[index].name,
          size: size,
          wrapped: true
        )
        .offset(x: xOffset(index: index), y: 0)
      }
      
      PBMultipleUsersIndicator(usersCount: filteredUsers.1, size: size)
        .offset(x: xOffset(index: filteredUsers.0.endIndex), y: 0)
    }
    .padding(.leading, leadingPadding)
    .frame(width: totalWidth, alignment: .leading)
  }
}

public extension PBMultipleUsers {

  enum BubbleSize {
    case small, medium, large, xLarge
  }
  enum BubbleCount {
    case two, three, four
  }

  var multipleUsersBubbleVariant: some View {
    CircularLayout {
          userBubbleView
    }
    .padding(5)
    .background(Color.background(.light))
    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
  }
  var userBubbleView: some View {
    ForEach(filteredUsers.0.indices, id: \.self) { index in
      let avatarSize = avatarSize(for: index, total: filteredUsers.0.count)
        PBAvatar(
          image: filteredUsers.0[index].image,
          name: filteredUsers.0[index].name,
          size: .custom(avatarSize),
          wrapped: true
        )
        .padding(index <= 1 ? -1 : -5)
        .offset(x: avatarXPosition(for: index, total: filteredUsers.0.count), y: avatarYPosition(for: index, total: filteredUsers.0.count))
       
    }
  }
  
  func avatarSize(for index: Int, total: Int) -> CGFloat {
      let sizes: [BubbleSize: [Int: [CGFloat]]] = [
          .small: [
              1: [20],
              2: [20, 12],
              3: [16, 12, 10],
              4: [16, 12, 10, 8]
          ],
          .medium: [
              1: [32],
              2: [32, 16],
              3: [24, 20, 16],
              4: [28, 20, 16, 12]
          ],
          .large: [
              1: [44],
              2: [44, 20],
              3: [32, 24, 20],
              4: [36, 28, 24, 16]
          ],
          .xLarge: [
              1: [56],
              2: [56, 24],
              3: [44, 32, 24],
              4: [44, 32, 24, 16]
          ]
      ]
    return sizes[bubbleSize]?[total]?[index] ?? 0
  }

  func avatarXPosition(for index: Int, total: Int) -> CGFloat {
    switch (total, index) {
    case (2, 0):
      return -6
    case (2, 1):
      return 8
    case (3, 0):
      return -6
    case (3, 1):
      return 3
    case (3, 2):
      return 8
    case (4, 0):
      return -6
    case (4, 1):
      return 1
    case (4, 2):
      return -6
    case (4, 3):
      return 22
    default:
      return 0
    }
  }
  func avatarYPosition(for index: Int, total: Int) -> CGFloat {
    switch (total, index) {
    case (2, 0):
      return 0
    case (2, 1):
      return -2
    case (3, 0):
      return 0
    case (3, 1):
      return -4
    case (3, 2):
      return 4
    case (4, 0):
      return 0
    case (4, 1):
      return 4
    case (4, 2):
      return -4
    case (4, 3):
      return -8
    default:
      return 0
    }
  }
}
#Preview {
  registerFonts()
  return PBMultipleUsers()
}
