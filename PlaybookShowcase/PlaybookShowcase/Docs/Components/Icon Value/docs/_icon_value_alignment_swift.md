```swift
VStack(alignment: .leading, spacing: Spacing.medium) {
  HStack {
    PBIconValue(icon: .heart, iconSize: .large, text: "93")
  }
  .frame(maxWidth: .infinity, alignment: .leading)
  HStack {
    PBIconValue(icon: .comment, iconSize: .large, text: "5")
  }
  .frame(maxWidth: .infinity, alignment: .center)
  HStack {
    PBIconValue(icon: .clock, iconSize: .large, text: "15m")
  }
  .frame(maxWidth: .infinity, alignment: .trailing)
}
```
