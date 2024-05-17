![Select-Disabled](https://github.com/powerhome/playbook-swift/assets/112719604/daad1091-dbfe-4c7f-8a23-2da5ae490f70)

```swift
PBSelect(
  title: "Favorite Food",
  options: defaultOptions,
  style: .disabled
) { selected in
  disabledState = selected
}
```
