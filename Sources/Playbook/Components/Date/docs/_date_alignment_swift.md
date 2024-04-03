![date-alignment](https://github.com/powerhome/playbook-swift/assets/54749071/2cdf7d64-81b2-47a4-96ad-35f2b6b104a6)

```swift
 VStack(spacing: Spacing.small) {
  HStack {
    PBDate(
      Date().makeDate(year: 1995, month: 12, day: 25),
      variant: .standard,
      typography: .title4
    )
  }
  .frame(maxWidth: .infinity, alignment: .leading)
  HStack {
    PBDate(
      Date().makeDate(year: 2020, month: 12, day: 25),
      variant: .withIcon(isStandard: true),
      typography: .title4,
      iconSize: .x1
    )
  }
  .frame(maxWidth: .infinity, alignment: .center)
  HStack {
    PBDate(
    Date(),
    variant: .short,
    typography: .title4
   )
  }
  .frame(maxWidth: .infinity, alignment: .trailing)
}
```
