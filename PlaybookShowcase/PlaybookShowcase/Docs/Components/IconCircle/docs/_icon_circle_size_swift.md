```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  let pBIconSizes = [PBIcon.IconSize.small, PBIcon.IconSize.x1, PBIcon.IconSize.large]
    ForEach(pBIconSizes, id: \.self) { size in
      PBIconCircle(FontAwesome.rocket, size: size)
  }
}
```
