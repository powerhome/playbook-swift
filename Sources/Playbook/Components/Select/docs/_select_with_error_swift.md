![Select-Error](https://github.com/powerhome/playbook-swift/assets/112719604/a0561101-ae98-454c-bdb7-b6e51953ac28)


```swift
 PBSelect(
  title: "Favorite Food",
  options: defaultOptions,
  style: .error("Please make a valid selection")
) { selected in
  errorState = selected
}
```
