![Timestamp-Timezones](https://github.com/powerhome/playbook-swift/assets/112719604/0a5d2ee1-28c1-4629-b46a-ec6547f4d543)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  Group {
    PBTimestamp(
      Date(),
      showDate: false,
      showTimeZone: true,
      timeZone: "America/New_York"
    )
    .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

    PBTimestamp(
      Date(),
      showTimeZone: true,
      timeZone: "America/New_York"
    )
    .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

    PBTimestamp(
      Date().addingTimeInterval(addThreeYear),
      showTimeZone: true,
      timeZone: "America/New_York"
    )
    .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

    PBTimestamp(
      Date().addingTimeInterval(subOneYear),
      showTimeZone: true,
      timeZone: "America/New_York"
    )
    .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
  }

  Group {
    PBTimestamp(
      Date(),
      showDate: false,
      showTimeZone: true,
      timeZone: "Asia/Hong_Kong"
    )
    .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

    PBTimestamp(
      Date(),
      showTimeZone: true,
      timeZone: "Asia/Hong_Kong"
    )
    .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

    PBTimestamp(
      Date().addingTimeInterval(addThreeYear),
      showTimeZone: true,
      timeZone: "Asia/Hong_Kong"
    )
    .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)

    PBTimestamp(
      Date().addingTimeInterval(subOneYear),
      showTimeZone: true,
      timeZone: "Asia/Hong_Kong"
    )
    .frame(minWidth: minWidth, maxWidth: .infinity, alignment: .leading)
  }
}
```
