```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  ForEach(PBIcon.IconSize.allCases, id: \.fontSize) { size in
    HStack(spacing: Spacing.xSmall) {
      PBIcon.fontAwesome(.atlas, size: size)
        Text(size.rawValue)
    }
  }
}
```
