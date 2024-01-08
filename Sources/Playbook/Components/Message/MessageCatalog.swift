//
//  MessageCatalog.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

public struct MessageCatalog: View {
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
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
              timestamp: Date().addingTimeInterval(-200000)
            ) {}

            PBMessage(
              label: "Keith Craig",
              timestamp: Date().addingTimeInterval(-200000)
            ) {
              Image("Forest", bundle: .module).resizable().frame(width: 240, height: 240)
            }

            PBMessage(
              label: "Keith Craig",
              message: "Please hold for one moment, I will check with my manager.",
              timestamp: Date().addingTimeInterval(-200000)
            ) {
              Image("Forest", bundle: .module).resizable().frame(width: 240, height: 240)
            }
          }
        }

        #if os(macOS)
          PBDoc(title: "With timestamp hover") {
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
        #endif
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Message")
  }
}
