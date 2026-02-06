![Message-Default](https://github.com/powerhome/playbook-swift/assets/112719604/26db10f0-3f82-4360-8359-f968f6e71e27)

```swift
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
```
