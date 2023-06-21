//
//  MessageCatalog.swift
//  
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct MessageCatalog: View {
  public var body: some View {
    List {
      Section("Default") {
        PBMessage(
          avatar: picAnna,
          label: "Anna Black",
          message: "How can we assist you today?",
          timestamp: Date().addingTimeInterval(-20)
        )
        .padding(.vertical)

        PBMessage(
          avatar: picPatric,
          label: "Patrick Welch",
          message: "We will escalate this issue to a Senior Support agent.",
          timestamp: Date().addingTimeInterval(-540),
          timestampAlignment: .leading
        )
        .padding(.vertical)

        PBMessage(
          avatar: picLuccile,
          label: "Lucille Sanchez",
          message: "Application for Kate Smith is waiting for your approval",
          timestamp: Date().addingTimeInterval(-200000)
        )
        .padding(.vertical)

        PBMessage(
          avatar: PBAvatar(name: "Tuany Worker", size: .xSmall),
          label: "Beverly Reyes",
          message: "We are so sorry you had a bad experience!",
          timestamp: Date().addingTimeInterval(-200000)
        )
        .padding(.vertical)

        PBMessage(
          label: "Keith Craig",
          message: "Please hold for one moment, I will check with my manager.",
          timestamp: Date().addingTimeInterval(-200000)
        ) {}
        .padding(.vertical)

        PBMessage(
          label: "Keith Craig",
          timestamp: Date().addingTimeInterval(-200000)
        ) {
          Image("Forest", bundle: .module).resizable().frame(width: 240, height: 240)
        }
        .padding(.vertical)

        PBMessage(
          label: "Keith Craig",
          message: "Please hold for one moment, I will check with my manager.",
          timestamp: Date().addingTimeInterval(-200000)
        ) {
          Image("Forest", bundle: .module).resizable().frame(width: 240, height: 240)
        }
        .padding(.vertical)
      }
      .listRowSeparator(.hidden)

      #if os(macOS)
      Section("With timestamp hover") {
        PBMessage(
          avatar: avatarXSmall,
          label: userName,
          message: message,
          timestamp: Date(),
          timestampAlignment: .leading,
          changeTimeStampOnHover: true
        )
        .padding(.vertical)

        PBMessage(
          avatar: avatarXSmall,
          label: userName,
          message: message,
          timestamp: Date(),
          timestampAlignment: .trailing,
          changeTimeStampOnHover: true
        )
        .padding(.vertical)
      }
      #endif
    }
    .navigationTitle("Message")
  }
}
