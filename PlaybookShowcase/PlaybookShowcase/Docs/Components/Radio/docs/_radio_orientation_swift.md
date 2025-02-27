![Radio-Orientation](https://github.com/powerhome/playbook-swift/assets/112719604/4e186f96-4c76-424f-ae49-440012c51c28)

```swift
VStack(alignment: .leading) {
  PBRadio(
    items: [
      PBRadioItem("Power"),
      .init("Nitro"),
      .init("Google")
    ],
    orientation: .horizontal,
    selected: $selectedOrientation
  )
}
```
