![Message-Default](https://github.com/powerhome/playbook-swift/assets/112719604/26db10f0-3f82-4360-8359-f968f6e71e27)

```swift
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
      Image("Forest").resizable().frame(width: 240, height: 240)
    }
  PBMessage(
    label: "Keith Craig",
    message: "Please hold for one moment, I will check with my manager.",
    timestamp: Date().addingTimeInterval(-200000)
  ) {
      Image("Forest").resizable().frame(width: 240, height: 240)
    }
}
```
