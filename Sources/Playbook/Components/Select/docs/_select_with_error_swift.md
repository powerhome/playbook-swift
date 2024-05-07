```swift
 PBSelect(
  title: "Favorite Food",
  options: defaultOptions,
  style: .error("Please make a valid selection")
) { selected in
  errorState = selected
}
```
