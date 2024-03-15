```swift
VStack(alignment: .leading, spacing: Spacing.medium) {
  PBButton(title: "Toggle State", action: {
        canShowTooltip.toggle()
})
 .pbFont(.body)
HStack(spacing: Spacing.none) {
  Text("Tooltip is: \(canShowTooltip == true ? "enabled" : "disabled")")
          .pbFont(.body)
}
  Text("Hover me.")
    .pbFont(.body)
    .padding(.leading, Spacing.none)
    .pbTooltip(canPresent: canShowTooltip, placement: .top, text: "Whoa, I'm a tooltip.")
}
```
