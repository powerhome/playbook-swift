![Radio-Default](https://github.com/powerhome/playbook-swift/assets/112719604/06d56028-9c66-448f-bd63-45dac3ee36ca)

```swift
VStack(alignment: .leading) {
  PBRadio(
    items: [
      PBRadioItem("Power"),
      .init("Nitro"),
      .init("Google")
    ],
    orientation: .vertical,
    selected: $selectedDefault
  )
}
```
