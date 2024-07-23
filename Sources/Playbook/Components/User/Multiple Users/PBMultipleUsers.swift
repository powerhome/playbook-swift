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
//    multipleUsersView
//    multipleUsersBubbleVariant
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
}

public extension PBMultipleUsers {

  enum BubbleSize {
    case small, medium, large, xLarge
  }
  enum BubbleCount {
    case two, three, four
  }
//  var smallBubbleCount: [CGFloat] {
//    switch bubbleCount {
//    case .two: return [20, 12]
//    case .three: return [16, 12, 10]
//    case .four: return [16, 12, 10, 8]
//    }
//  }
//  var medBubbleCount: [CGFloat] {
//    switch bubbleCount {
//    case .two: return [32, 16]
//    case .three: return [24, 20, 16]
//    case .four: return [28, 20, 16, 12]
//    }
//  }
//  var largeBubbleCount: [CGFloat] {
//    switch bubbleCount {
//    case .two: return [44, 20]
//    case .three: return [32, 24, 20]
//    case .four: return [36, 28, 24, 16]
//    }
//  }
//  var xLargeBubbleCount: [CGFloat] {
//    switch bubbleCount {
//    case .two: return [56, 24]
//    case .three: return [44, 32, 24]
//    case .four: return [44, 32, 24, 16]
//    }
//  }
//  var smallBubbleSizes: [CGFloat] {
//    switch bubbleSize {
//    case .small: return smallBubbleCount
//    case .medium: return medBubbleCount
//    case .large: return largeBubbleCount
//    case .xLarge: return xLargeBubbleCount
//    }
//  }
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
  var multipleUsersBubbleVariant: some View {
    CircularLayout {
          userBubbleView
    }
    .frame(width: 35, height: 35)
    .background(Color.background(.light))
    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
  }
  var userBubbleView: some View {
    ForEach(filteredUsers.0.indices, id: \.self) { index in
      let avSize = avatarSize(for: index, total: filteredUsers.0.count)
        PBAvatar(
          image: filteredUsers.0[index].image,
          name: filteredUsers.0[index].name,
          size: .custom(avSize),
          wrapped: true
        )
        .padding(index == 2 ? -1.5 : -1.6)
    
        // use the index to continue this ??
        .offset(x: index == 1 ? -1 : -4, y: 0)
       
        //
    }
    .padding(-2.2)
  }
  func avatarSize(for index: Int, total: Int) -> CGFloat {
         // I think these are ok for small but the order is off
    if bubbleSize == .small {
     switch total {
      
      case 1:
        print("Index1: \(index)")
        return 20
      case 2:
        //  //[20, 12]
        print("Index2: \(index)")
        return index == 0 ? 20 : 12
        
      case 3:
        //[16, 12, 10]
        print("Index3: \(index)")
        return index == 1 ? 10 : 16
      case 4:
        // [16, 12, 10, 8]
        print("Index4: \(index)")
        return index == 1 ? 16 : index == 2 ? 12 : index == 3 ? 10 : 8
      default:
        return 8
      }
     
    }
    return CGFloat(total)
     }
}
#Preview {
  registerFonts()
  return PBMultipleUsers()
}
