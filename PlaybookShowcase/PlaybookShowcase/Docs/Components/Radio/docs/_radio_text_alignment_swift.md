![Radio-Text-Alignment](https://github.com/powerhome/playbook-swift/assets/112719604/6875b99c-83d1-4e1a-8fe2-1b174e280bb6)

```swift
VStack(alignment: .leading) {
  PBRadio(
    items: [
      PBRadioItem("Power"),
      .init("Nitro"),
      .init("Google")
    ],
    orientation: .horizontal,
    textAlignment: .vertical,
    selected: $selectedAlignment
  )
}
```
