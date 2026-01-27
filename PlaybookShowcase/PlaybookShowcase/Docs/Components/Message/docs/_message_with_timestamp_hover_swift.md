```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBMessage(
    avatar: AnyView(Mocks.avatarXSmall),
    sender: Mocks.userName,
    timestamp: Date(),
    message: AttributedString(Mocks.message)
  )
  PBMessage(
    avatar: AnyView(Mocks.avatarXSmall),
    sender: Mocks.userName,
    timestamp: Date(),
    message: AttributedString(Mocks.message)
  )
}
```
