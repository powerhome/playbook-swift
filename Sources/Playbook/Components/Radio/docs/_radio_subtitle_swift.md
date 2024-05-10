![Radio-Subtitle](https://github.com/powerhome/playbook-swift/assets/112719604/47419319-0752-4548-ae8f-7f391e3e71dd)

```swift
VStack(alignment: .leading) {
  PBRadio(
    items: [
      PBRadioItem("Power", subtitle: "subtitle")
    ],
    selected: $selectedSubtitle
  )
}
```
