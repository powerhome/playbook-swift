![Multiple-Users-Reverse](https://github.com/powerhome/playbook-swift/assets/112719604/a805caed-dd22-4c2c-89cc-fc6a799e3999)


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
