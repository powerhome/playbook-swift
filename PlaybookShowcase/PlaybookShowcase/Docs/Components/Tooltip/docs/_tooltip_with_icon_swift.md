```swift
HStack(spacing: Spacing.medium) {
  PBButton(title: "Tooltip With Icon")
    .pbFont(.body)
    .pbTooltip(icon: .paperPlane, placement: .top, text: "Send Email.")
  PBButton(title: "Tooltip With Icon")
    .pbFont(.body)
    .pbTooltip(icon: .paperPlane, placement: .bottom, text: "Send Email.")
  PBButton(title: "Tooltip With Icon")
    .pbFont(.body)
    .pbTooltip(icon: .paperPlane, placement: .trailing, text: "Send Email.")
  PBButton(title: "Tooltip With Icon")
    .pbFont(.body)
    .pbTooltip(icon: .paperPlane, placement: .leading, text: "Send Email.")
}
```
