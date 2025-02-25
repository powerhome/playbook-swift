![Radio-Spacing](https://github.com/powerhome/playbook-swift/assets/112719604/a0d246c0-9635-49f0-a2d5-5a6a19a5086c)

```swift
HStack(alignment: .top) {
  PBRadio(
    items: [
      PBRadioItem("Small"),
      .init("Small Spacing"),
      .init("Small Power")
    ],
    orientation: .vertical,
    spacing: Spacing.small,
    selected: $selectedSpacing
  )
  PBRadio(
    items: [
      PBRadioItem("Medium"),
      .init("Medium Spacing"),
      .init("Medium Power")
    ],
    orientation: .vertical,
    spacing: Spacing.medium,
    selected: $selectedSpacing
  )
  PBRadio(
    items: [
      PBRadioItem("Large"),
      .init("Large Spacing"),
      .init("Large Power")
    ],
    orientation: .vertical,
    spacing: Spacing.large,
    selected: $selectedSpacing
  )
}
```
