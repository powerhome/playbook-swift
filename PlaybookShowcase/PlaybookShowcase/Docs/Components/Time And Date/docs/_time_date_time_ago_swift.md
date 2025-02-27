![Timestamp-Time-Ago](https://github.com/powerhome/playbook-swift/assets/112719604/9a599849-f181-45aa-8bfd-5d9d874d6a2b)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBTimestamp(
    Date().addingTimeInterval(-10),
    showUser: true,
    text: "Maricris Nanota",
    variant: .elapsed
  )
  .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

  PBTimestamp(
    Date().addingTimeInterval(-36000),
    variant: .elapsed
  )
  .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

  PBTimestamp(
    Date().addingTimeInterval(-36000),
    variant: .hideUserElapsed
  )
  .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
}
```
