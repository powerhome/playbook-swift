![date-unstyled](https://github.com/powerhome/playbook-swift/assets/54749071/8f0d6a45-0ce8-4cd4-99e5-2089a9371e82)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBDate(Date(), variant: .short, typography: .body)
  PBDate(Date(), variant: .standard, typography: .title1)
  PBDate(Date(), variant: .withIcon(isStandard: false), typography: .subcaption, iconSize: .xSmall)
}
```
