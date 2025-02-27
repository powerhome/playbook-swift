![Timestamp-Default](https://github.com/powerhome/playbook-swift/assets/112719604/ee388049-004f-498b-b922-97d548b756f7)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBTimestamp(
    Date(),
    showDate: false
  )
  .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
  PBTimestamp(
    Date()
  )
  .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
  PBTimestamp(
    Date().addingTimeInterval(addThreeYear)
  )
  .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
  PBTimestamp(
    Date().addingTimeInterval(subOneYear)
  )
  .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
}
```
