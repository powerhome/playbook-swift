```swift
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
```
