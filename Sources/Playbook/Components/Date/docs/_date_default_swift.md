![date-default](https://github.com/powerhome/playbook-swift/assets/54749071/4a151fc4-bb33-44c9-ae57-5c8af28e24c2)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBDate(
    Date(),
    variant: .short
  )
  PBDate(
    Date().makeDate(year: 2012, month: 8, day: 3),
    variant: .standard
  )
  PBDate(
    Date().makeDate(year: 2017, month: 12, day: 3),
    variant: .dayDate(showYear: true)
  )
  Spacer()
  PBDate(
    Date(),
    variant: .short, 
    typography: .title4
  )
  PBDate(
    Date().makeDate(year: 2012, month: 8, day: 3),
    variant: .standard, 
    typography: .title4
  )
  PBDate(
    Date().makeDate(year: 2017, month: 12, day: 3),
    variant: .dayDate(showYear: true),
    typography: .title4
  )
}
```
