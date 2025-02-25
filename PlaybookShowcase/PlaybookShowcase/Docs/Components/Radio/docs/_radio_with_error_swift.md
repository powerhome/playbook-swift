![Radio-Error](https://github.com/powerhome/playbook-swift/assets/112719604/8b409da0-d658-4b39-88a4-ddb1601f644f)

```swift
VStack(alignment: .leading) {
  PBRadio(
    items: [
    PBRadioItem("Power")
    ],
    orientation: .vertical,
    selected: $selectedError,
    errorState: true
  )
}
```
