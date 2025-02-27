```swift
HStack(spacing: Spacing.medium) {
  PBButton(title: "1s Delay")
    .pbFont(.body)
    .pbTooltip(delay: 1.0, text: "1s Open/Close Delay.")
  PBButton(title: "Open Only")
    .pbFont(.body)
    .pbTooltip(delay: 1.0, delayType: .open, text: "1s Open Delay.")
  PBButton(title: "Close Only")
    .pbFont(.body)
    .pbTooltip(delay: 1.0, delayType: .close, text: "1s Close Delay.")
}
```
