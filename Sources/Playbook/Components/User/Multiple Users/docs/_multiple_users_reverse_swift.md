```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBMultipleUsers(
    users: Mocks.multipleUsers,
    size: .small,
    reversed: true
  )
  PBMultipleUsers(
    users: Mocks.twoUsers,
    size: .small,
    reversed: true
  )
}
```
