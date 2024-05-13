![Timestamp-Alignment](https://github.com/powerhome/playbook-swift/assets/112719604/ef85a6f4-cf2a-4c73-9640-28139a47370f)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  Group {
    PBTimestamp(
    Date(),
    showDate: false
    )
    .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

    PBTimestamp(Date())
     .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

    PBTimestamp(Date().addingTimeInterval(addThreeYear))
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

    PBTimestamp(Date().addingTimeInterval(subOneYear))
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
  }

  Group {
    PBTimestamp(
      Date(),
      showDate: false
    )
    .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .center)

    PBTimestamp(Date())
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .center)

    PBTimestamp(Date().addingTimeInterval(addThreeYear))
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .center)

        PBTimestamp(Date().addingTimeInterval(subOneYear))
          .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .center)
  }

  Group {
    PBTimestamp(
      Date(),
      showDate: false
    )
    .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .trailing)

    PBTimestamp(Date())
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .trailing)

    PBTimestamp(Date().addingTimeInterval(addThreeYear))
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .trailing)

    PBTimestamp(Date().addingTimeInterval(subOneYear))
      .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .trailing)
  }
}
```
