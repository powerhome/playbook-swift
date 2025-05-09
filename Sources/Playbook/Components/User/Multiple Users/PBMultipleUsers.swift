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
  var isActive: Bool
  @State private var avSize: CGFloat = 20
  @Environment(\.colorScheme) var colorScheme

  public init(
    users: [PBUser] = [],
    size: PBAvatar.Size = .small,
    variant: Variant = .linear,
    reversed: Bool = false,
    bubbleSize: BubbleSize = .small,
    bubbleCount: BubbleCount = .two,
    maxDisplayedUsers: Int = 4,
    isActive: Bool = true
  ) {
    self.users = users
    self.size = size
    self.variant = variant
    self.reversed = reversed
    self.bubbleSize = bubbleSize
    self.bubbleCount = bubbleCount
    self.maxDisplayedUsers = maxDisplayedUsers
    self.isActive = isActive
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
    case .bubble: multipleUsersBubbleView
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
          wrapped: true,
          isActive: isActive
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
  
  var multipleUsersBubbleView: some View {
    CircularLayout {
      userBubbleView
    }
    .frame(width: frameSize, height: frameSize)
    .background(bubbleBackgroundColor)
    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
  }
  var userBubbleView: some View {
    ForEach(filteredUsers.0.indices, id: \.self) { index in
      let avatarSize = avatarSize(for: index, total: filteredUsers.0.count)
      PBAvatar(
        image: filteredUsers.0[index].image,
        name: filteredUsers.0[index].name,
        size: .custom(avatarSize),
        wrapped: true,
        isActive: isActive
      )
      .padding(index <= 1 ? -1 : -4)
      .offset(
        x: avatarXPosition(for: index, total: filteredUsers.0.count),
        y: avatarYPosition(for: index, total: filteredUsers.0.count)
      )
    }
  }
  
  var bubbleBackgroundColor: Color {
    switch colorScheme {
    case .light: return Color.background(.light)
    case .dark: return Color.Card.background(.dark)
    default:
      return Color.background(.light)
    }
  }
  
  func avatarSize(for index: Int, total: Int) -> CGFloat {
    let sizes: [BubbleSize: [Int: [CGFloat]]] = [
      .small: [
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
        2: [44, 20],
        3: [32, 24, 20],
        4: [36, 28, 24, 16]
      ],
      .xLarge: [
        2: [56, 24],
        3: [44, 32, 24],
        4: [44, 32, 24, 16]
      ]
    ]
    return sizes[bubbleSize]?[total]?[index] ?? 0
  }
  func avatarXPosition(for index: Int, total: Int) -> CGFloat {
    let positions: [BubbleSize: [Int: [CGFloat]]] = [
      .small: [
        2: [-6, 8],
        3: [-6, 3, 8],
        4: [-6, 1, -4, 24]
      ],
      .medium: [
        2: [-6, 12],
        3: [-10, 1, 13],
        4: [-9, -7, -6, 41]
      ],
      .large: [
        2: [-8, 18],
        3: [-12, 2, 16],
        4: [-13, -13, -8, 55]
      ],
      .xLarge: [
        2: [-9, 22],
        3: [-12, -3, 22],
        4: [-12, -12, -10, 65]
      ]
    ]
    return positions[bubbleSize]?[total]?[index] ?? 0
  }
  
  func avatarYPosition(for index: Int, total: Int) -> CGFloat {
    let positions: [BubbleSize: [Int: [CGFloat]]] = [
      .small: [
        2: [0, -2],
        3: [0, -4, 4],
        4: [0, 4, -4, -10]
      ],
      .medium: [
        2: [0, -3],
        3: [4, -5, 4],
        4: [8, 6, -9, -15]
      ],
      .large: [
        2: [0, -7],
        3: [4, -7, 5],
        4: [16, 9, -14, -20]
      ],
      .xLarge: [
        2: [3, -6],
        3: [9, -6, 7],
        4: [15, 10, -15, -25]
      ]
    ]
    return positions[bubbleSize]?[total]?[index] ?? 0
  }
  
  var frameSize: CGFloat {
    switch bubbleSize {
    case .small: return 40
    case .medium: return 60
    case .large: return 75
    case .xLarge: return 90
    }
  }
}

#Preview {
  registerFonts()
  return VStack {
    PBMultipleUsers(users: Mocks.multipleUsers, variant: .linear)
    PBMultipleUsers(users: Mocks.multipleUsers, variant: .bubble)
  }
  .padding()
}
