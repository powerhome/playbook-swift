![Radio-Padding](https://github.com/powerhome/playbook-swift/assets/112719604/2f3cdd9e-2293-4d93-a50d-fefb08510233)

```swift
VStack(alignment: .leading) {
  PBRadio(
    items: [
      PBRadioItem("Small")
    ],
    orientation: .vertical,
    padding: Spacing.small,
    selected: $selectedPadding
  )
  PBRadio(
    items: [
      PBRadioItem("Medium")
    ],
    orientation: .vertical,
    padding: Spacing.medium,
    selected: $selectedPadding
  )
  PBRadio(
    items: [
      PBRadioItem("Large")
    ],
    orientation: .vertical,
    padding: Spacing.large,
    selected: $selectedPadding
  )
}
```
