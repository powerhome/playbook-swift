```swift
HStack(spacing: Spacing.medium) {
  Text("Hover here (Top)")
    .pbFont(.body)
    .pbTooltip(placement: .top, text: "Whoa, I'm a tooltip.")
  Text("Hover here (Bottom)")
    .pbFont(.body)
    .pbTooltip(placement: .bottom, text: "Whoa, I'm a tooltip.")
  Text("Hover here (Right)")
    .pbFont(.body)
    .pbTooltip(placement: .trailing, text: "Whoa, I'm a tooltip.")
  Text("Hover here (Left)")
    .pbFont(.body)
    .pbTooltip(placement: .leading, text: "Whoa, I'm a tooltip.")
}
```
