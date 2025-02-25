![date-varients](https://github.com/powerhome/playbook-swift/assets/54749071/3d70d50b-b0c5-4e83-9c58-4ed860c9c5cf)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBDate(Date(), variant: .withIcon(isStandard: true), typography: .caption, iconSize: .xSmall)
  PBDate(Date(), variant: .standard, typography: .title4)
  PBDate(Date(), variant: .withIcon(isStandard: true), typography: .title4, iconSize: .x1)
  PBDate(Date(), variant: .dayDate, typography: .title4)
  PBDate(Date(), variant: .withIcon(isStandard: false), typography: .title4, iconSize: .x1)
}
```
