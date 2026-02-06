//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBMessage.swift
//

import SwiftUI

public struct PBMessage<Avatar: View, Sender: View, Timestamp: View, Content: View>: View {
  let avatar: Avatar?
  let sender: Sender
  let timestamp: Timestamp?
  let message: AttributedString?
  let content: Content?
  let isSenderActive: Bool
  let isLoading: Bool

  public init(
    avatar: Avatar?,
    sender: Sender,
    timestamp: Timestamp?,
    message: AttributedString? = nil,
    isSenderActive: Bool = true,
    isLoading: Bool = false,
    @ViewBuilder content: (() -> Content) = { EmptyView() }
  ) {
    self.avatar = avatar
    self.sender = sender
    self.timestamp = timestamp
    self.message = message
    self.isSenderActive = isSenderActive
    self.isLoading = isLoading
    self.content = content()
  }
  
  public var body: some View {
    HStack(alignment: .top, spacing: nil) {
      if let avatar = avatar {
        avatar
          .opacity(isLoading ? 0.8 : 1)
      }
      VStack(alignment: .leading, spacing: Spacing.none) {
        HStack(spacing: Spacing.xSmall) {
          sender
            .pbFont(.messageTitle, color: isLoading || !isSenderActive ? .text(.light) : .text(.default))
          Group {
            if isLoading {
              PBLoader()
            } else if let timestamp = timestamp {
              timestamp
            }
          }
          .frame(height: 16.8)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        if let message = message {
          Text(message)
            .pbFont(.messageBody, color: isLoading ? .text(.light) : .text(.default))
        }
        content
      }
    }
    .frame(maxWidth: .infinity, alignment: .topLeading)
  }
}

// Convenience initializer for String sender and Date timestamp
public extension PBMessage where Sender == Text, Timestamp == PBTimestamp {
  init(
    avatar: Avatar?,
    sender: String,
    timestamp: Date?,
    message: AttributedString? = nil,
    isSenderActive: Bool = true,
    isLoading: Bool = false,
    @ViewBuilder content: (() -> Content) = { EmptyView() }
  ) {
    self.avatar = avatar
    self.sender = Text(sender)
    self.timestamp = timestamp.map { PBTimestamp($0, amPmStyle: .short, showDate: false) }
    self.message = message
    self.isSenderActive = isSenderActive
    self.isLoading = isLoading
    self.content = content()
  }
}


#Preview {
  registerFonts()
  return PBMessage(
    avatar: AnyView(Mocks.picPatric),
    sender: "Patrick Welch",
    timestamp: Date().addingTimeInterval(-540),
    message: AttributedString("We will escalate this issue to a Senior Support agent.")
  )
}
