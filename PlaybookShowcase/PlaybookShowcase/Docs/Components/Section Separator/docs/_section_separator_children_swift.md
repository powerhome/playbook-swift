![Section-Separator-Children](https://github.com/powerhome/playbook-swift/assets/112719604/a9e654a3-d8ee-427b-b886-cdf616d38e24)

```swift
PBSectionSeparator(variant: .dashed) {
  PBCard(alignment: .center, borderRadius: BorderRadius.rounded, padding: Spacing.xxSmall, width: 70) {
    Text("Today")
      .minimumScaleFactor(0.5)
      .lineLimit(1)
      .pbFont(.caption)
      .frame(maxWidth: .infinity, alignment: .center)
  }
}
```
