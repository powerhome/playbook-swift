//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  MessageCatalog.swift
//

import SwiftUI
import Playbook

public struct MessageCatalog: View {
  @State private var isLoading: Bool = true
  @State private var showPopover: Bool = false

  public var body: some View {
    PBDocStack(title: "Message") {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Message Loading") {
        messsagingLoadingView
      }
      PBDoc(title: "On User Click") {
        onUserClickView
      }
      PBDoc(title: "Inactive User") {
        inactiveUserView
      }
    }
  }
}

extension MessageCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBMessage(
        avatar: AnyView(Mocks.picAnna),
        sender: "Anna Black",
        timestamp: Date().addingTimeInterval(-20),
        message: AttributedString("How can we assist you today?")
      )

      PBMessage(
        avatar: AnyView(Mocks.picPatric),
        sender: "Patrick Welch",
        timestamp: Date().addingTimeInterval(-540),
        message: AttributedString("We will escalate this issue to a Senior Support agent.")
      )

      PBMessage(
        avatar: AnyView(Mocks.picLuccile),
        sender: "Lucille Sanchez",
        timestamp: Date().addingTimeInterval(-200000),
        message: AttributedString("Application for Kate Smith is waiting for your approval")
      )

      PBMessage(
        avatar: AnyView(PBAvatar(name: "Beverly Reyes", size: .xSmall)),
        sender: "Beverly Reyes",
        timestamp: Date().addingTimeInterval(-200000),
        message: AttributedString("We are so sorry you had a bad experience!")
      )

      PBMessage(
        avatar: nil,
        sender: "Keith Craig",
        timestamp: Date().addingTimeInterval(-200000),
        message: AttributedString("Please hold for one moment, I will check with my manager.")
      )

      PBMessage(
        avatar: nil,
        sender: "Keith Craig",
        timestamp: Date().addingTimeInterval(-200000)
      ) {
        Image("Forest").resizable().frame(width: 240, height: 240)
      }

      PBMessage(
        avatar: nil,
        sender: "Keith Craig",
        timestamp: Date().addingTimeInterval(-200000),
        message: AttributedString("Please hold for one moment, I will check with my manager.")
      ) {
        Image("Forest").resizable().frame(width: 240, height: 240)
      }
    }
  }

  var messsagingLoadingView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      VStack(alignment: .leading, spacing: Spacing.xxSmall) {
        Text("Load forever").pbFont(.caption)
        PBMessage(
          avatar: AnyView(Mocks.picPatric),
          sender: "Patrick Welch",
          timestamp: nil,
          message: AttributedString("We will escalate this issue to a Senior Support agent."),
          isLoading: true
        )
      }
      VStack(alignment: .leading, spacing: Spacing.xxSmall) {
        Text("Load for 5 seconds").pbFont(.caption)
        PBMessage(
          avatar: AnyView(Mocks.picPatric),
          sender: "Patrick Welch",
          timestamp: Date().addingTimeInterval(-540),
          message: AttributedString("We will escalate this issue to a Senior Support agent."),
          isLoading: isLoading
        )
        .onAppear {
          isLoading = true
          Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            self.isLoading = false
          }
        }
      }
    }
  }

  var onUserClickView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBMessage(
        avatar: Mocks.picPatric
          .onTapGesture { showPopover.toggle() }
          .popover(isPresented: $showPopover) {
            Text("User info popover")
              .padding()
          },
        sender: Text("Patrick Welch")
          .onTapGesture { showPopover.toggle() },
        timestamp: PBTimestamp(Date().addingTimeInterval(-540), amPmStyle: .short, showDate: false),
        message: AttributedString("Tap avatar or sender name to show popover.")
      )
    }
  }

  var inactiveUserView: some View {
    PBMessage(
      avatar: AnyView(PBAvatar(image: Image("Anna"), size: .xSmall, status: .offline)),
      sender: "Patrick Welch",
      timestamp: Date().addingTimeInterval(-540),
      message: AttributedString("We will escalate this issue to a Senior Support agent."),
      isSenderActive: false
    )
  }
}

#Preview {
  registerFonts()
  return MessageCatalog()
}
