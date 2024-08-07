//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  MultipleUsersCatalog.swift
//

import SwiftUI

public struct MultipleUsersCatalog: View {
  public var body: some View {
    PBDocStack(title: "Multiple Users") {
      PBDoc(title: "xSmall") {
        xsmallView
      }
     
      PBDoc(title: "Small") {
        smallView
      }
      
      PBDoc(title: "Small Reverse") {
        smallReverseView
      }
      
      PBDoc(title: "Small Bubble") {
        smallUserBubbleView
      }
      
      PBDoc(title: "Medium Bubble") {
        medUserBubbleView
      }
      
      PBDoc(title: "Large Bubble") {
        largeUserBubbleView
      }
      PBDoc(title: "Extra Large Bubble") {
        xLargeUserBubbleView
      }
    }
  }
}
extension MultipleUsersCatalog {
  var xsmallView: some View {
    PBMultipleUsers(users: Mocks.twoUsers, size: .xSmall)
  }
  var smallView: some View {
    PBMultipleUsers(users: Mocks.multipleUsers, size: .small)
  }
  var smallReverseView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBMultipleUsers(users: Mocks.multipleUsers, size: .small, reversed: true)
      PBMultipleUsers(users: Mocks.twoUsers, size: .small, reversed: true)
    }
  }
  var smallUserBubbleView: some View {
    HStack(spacing: Spacing.small) {
      PBMultipleUsers(
        users: Mocks.twoUsers,
        variant: .bubble,
        bubbleSize: .small,
        bubbleCount: .two
      )
      PBMultipleUsers(
        users: Mocks.threeUsers,
        variant: .bubble,
        bubbleSize: .small,
        bubbleCount: .three
      )
      PBMultipleUsers(
        users: Mocks.multipleUsers,
        variant: .bubble,
        bubbleSize: .small,
        bubbleCount: .four
      )
    }
  }
  var medUserBubbleView: some View {
    HStack(spacing: Spacing.small) {
      PBMultipleUsers(
        users: Mocks.twoUsers,
        variant: .bubble,
        bubbleSize: .medium,
        bubbleCount: .two
      )
      PBMultipleUsers(
        users: Mocks.threeUsers,
        variant: .bubble,
        bubbleSize: .medium,
        bubbleCount: .three
      )
      PBMultipleUsers(
        users: Mocks.multipleUsers,
        variant: .bubble,
        bubbleSize: .medium,
        bubbleCount: .four
      )
    }
  }
  var largeUserBubbleView: some View {
    HStack(spacing: Spacing.small) {
      PBMultipleUsers(
        users: Mocks.twoUsers,
        variant: .bubble,
        bubbleSize: .large,
        bubbleCount: .two
      )
      PBMultipleUsers(
        users: Mocks.threeUsers,
        variant: .bubble,
        bubbleSize: .large,
        bubbleCount: .three
      )
      PBMultipleUsers(
        users: Mocks.multipleUsers,
        variant: .bubble,
        bubbleSize: .large,
        bubbleCount: .four
      )
    }
  }
  var xLargeUserBubbleView: some View {
    HStack(spacing: Spacing.small) {
      PBMultipleUsers(
        users: Mocks.twoUsers,
        variant: .bubble,
        bubbleSize: .xLarge,
        bubbleCount: .two
      )
      PBMultipleUsers(
        users: Mocks.threeUsers,
        variant: .bubble,
        bubbleSize: .xLarge,
        bubbleCount: .three
      )
      PBMultipleUsers(
        users: Mocks.multipleUsers,
        variant: .bubble,
        bubbleSize: .xLarge,
        bubbleCount: .four
      )
    }
  }
}

#Preview {
  registerFonts()
  return MultipleUsersCatalog()
}
