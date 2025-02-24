//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  MessageCatalog.swift
//

import SwiftUI

public struct MessageCatalog: View {
  @State private var isLoading: Bool = true
  @State private var showUser1: Bool = false
  @State private var showUser2: Bool = false
  
  public var body: some View {
    PBDocStack(title: "Message") {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Message Loading") {
        messsagingLoadingView
      }
      #if os(macOS)
      PBDoc(title: "With timestamp hover") {
        hoveringView
      }
      #endif
      PBDoc(title: "On user click") {
        onUserClickView
      }
    }
    .popoverHandler(id: 9)
  }
}

extension MessageCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBMessage(
        avatar: AnyView(Mocks.picAnna),
        label: "Anna Black",
        message: "How can we assist you today?",
        timestamp: Date().addingTimeInterval(-20)
      )
      
      PBMessage(
        avatar: AnyView(Mocks.picPatric),
        label: "Patrick Welch",
        message: "We will escalate this issue to a Senior Support agent.",
        timestamp: Date().addingTimeInterval(-540),
        timestampAlignment: .leading
      )
      
      PBMessage(
        avatar: AnyView(Mocks.picLuccile),
        label: "Lucille Sanchez",
        message: "Application for Kate Smith is waiting for your approval",
        timestamp: Date().addingTimeInterval(-200000)
      )
      
      PBMessage(
        avatar: AnyView(PBAvatar(name: "Beverly Reyes", size: .xSmall)),
        label: "Beverly Reyes",
        message: "We are so sorry you had a bad experience!",
        timestamp: Date().addingTimeInterval(-200000)
      )
      
      PBMessage(
        label: "Keith Craig",
        message: "Please hold for one moment, I will check with my manager.",
        timestamp: Date().addingTimeInterval(-200000), 
        content:  {}
      )
      
      PBMessage(
        label: "Keith Craig",
        timestamp: Date().addingTimeInterval(-200000), 
        content: {
          Image("Forest").resizable().frame(width: 240, height: 240)
        }
      )
      
      PBMessage(
        label: "Keith Craig",
        message: "Please hold for one moment, I will check with my manager.",
        timestamp: Date().addingTimeInterval(-200000), 
        content: {
          Image("Forest").resizable().frame(width: 240, height: 240)
        }
      )
    }
  }
  
  var messsagingLoadingView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      VStack(alignment: .leading, spacing: Spacing.xxSmall) {
        Text("Load forever").pbFont(.caption)
        PBMessage(
          avatar: AnyView(Mocks.picPatric),
          label: "Patrick Welch",
          message: "We will escalate this issue to a Senior Support agent.",
          timestamp: nil,
          timestampAlignment: .leading,
          isLoading: .constant(true)
        )
      }
      VStack(alignment: .leading, spacing: Spacing.xxSmall) {
        Text("Load for 5 seconds").pbFont(.caption)
        PBMessage(
          avatar: AnyView(Mocks.picPatric),
          label: "Patrick Welch",
          message: "We will escalate this issue to a Senior Support agent.",
          timestamp: Date().addingTimeInterval(-540),
          timestampAlignment: .leading,
          isLoading: $isLoading
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
  
  var hoveringView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBMessage(
        avatar: AnyView(Mocks.avatarXSmall),
        label: Mocks.userName,
        message: Mocks.message,
        timestamp: Date(),
        timestampAlignment: .leading,
        changeTimeStampOnHover: true
      )
      
      PBMessage(
        avatar: AnyView(Mocks.avatarXSmall),
        label: Mocks.userName,
        message: Mocks.message,
        timestamp: Date(),
        timestampAlignment: .trailing,
        changeTimeStampOnHover: true
      )
    }
  }

  var onUserClickView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBMessage(
        avatar: AnyView(Mocks.picAnna),
        label: "Anna Black",
        message: "How can we assist you today?",
        timestamp: Date().addingTimeInterval(-20),
        isOnClick: true,
        onHeaderClick: { showDialog() }
      )
      .presentationMode(isPresented: $showUser1) {
          PBDialog(
              title: "Info Dialog",
              message: DialogCatalog.infoMessage,
              cancelButton: DialogCatalog().cancelButton { showUser1 = false },
              confirmButton: DialogCatalog().confirmationButton { showUser1 = false },
              size: .small
          )    .backgroundViewModifier(alpha: 0.2)
      }

      PBMessage(
        avatar: AnyView(Mocks.picPatric),
        label: "Patrick Welch",
        message: "We will escalate this issue to a Senior Support agent.",
        timestamp: Date().addingTimeInterval(-540),
        timestampAlignment: .leading,
        isOnClick: true, 
        onHeaderClick: { showPopover() }
      )
      .pbPopover(isPresented: $showUser2, id: 9, position: .top(-65, 50)) {
          Text("This is a popover")
      }
    }
  }

  private func showDialog() {
    showUser1.toggle()
    MessageCatalog.disableAnimation()
  }
  
  private func showPopover() {
    showUser2.toggle()
    MessageCatalog.disableAnimation()
  }
}

#Preview {
  registerFonts()
  return MessageCatalog()
}
