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
