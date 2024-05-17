![Radio-Custom](https://github.com/powerhome/playbook-swift/assets/112719604/f298dec8-1168-4992-9929-2ef9f8cd5800)

```swift
VStack(alignment: .leading) {
  if let selectedCustom = selectedCustom {
    Text("Your choice is: \(selectedCustom.title)")
      .pbFont(.detail(true), color: .text(.default))
  }
  PBRadio(
    items: [
      PBRadioItem("Custom Power"),
      .init("Custom Nitro"),
      .init("Custom Google")
    ],
    orientation: .vertical,
    selected: $selectedCustom
  )
}
```
