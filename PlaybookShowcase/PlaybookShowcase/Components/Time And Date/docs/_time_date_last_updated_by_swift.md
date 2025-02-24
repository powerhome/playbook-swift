![Timestamp-Last-Updated-By](https://github.com/powerhome/playbook-swift/assets/112719604/dc5179b2-4844-46a8-bfd1-c33c284ed9c6)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBTimestamp(
    Date().addingTimeInterval(-12),
    showUser: true,
    text: "Maricris Nanota",
    variant: .updated
  )
  .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

  PBTimestamp(
    Date().addingTimeInterval(-12),
    variant: .updated
  )
  .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
}
```
