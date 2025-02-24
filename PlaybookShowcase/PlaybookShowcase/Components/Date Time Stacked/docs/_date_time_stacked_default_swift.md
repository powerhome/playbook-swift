![Date-Time-Stacked-Default](https://github.com/powerhome/playbook-swift/assets/54749071/6bd21380-dcf8-46d6-a32e-8d1d529b273c)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBDateTimeStacked(
    timeZoneIdentifier: "EDT",
    isLowercase: true,
    isMonthStacked: true,
    isMonthBold: true
  )
  PBDateTimeStacked(
    timeZoneIdentifier: "EDT",
    isYearDisplayed: true,
    isLowercase: true,
    isMonthStacked: true,
    isMonthBold: true,
    isYearBold: true,
    dateVariant: .standard
  )
  PBDateTimeStacked(
    timeZoneIdentifier: "GMT+9",
    isLowercase: true,
    isMonthStacked: true,
    isMonthBold: true
  )
  PBDateTimeStacked(
    timeZoneIdentifier: "MDT",
    isLowercase: true,
    isMonthStacked: true,
    isMonthBold: true
  )
}
```
