```swift
VStack(spacing: Spacing.small) {
  ForEach(Color.DataColor.allCases, id: \.self) { color in
    PBIconCircle(FontAwesome.rocket, size: .small, color: Color.data(color))
  }
}
```
