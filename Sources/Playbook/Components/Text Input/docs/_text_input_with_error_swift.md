```swift
PBTextInput(
  "Email address",
  text: $textError,
  placeholder: "Enter email address",
  error: (true, "Insert a valid email"),
  style: .leftIcon(.user, divider: true)
)
PBTextInput(
  "Confirm email address",
  text: $textConfirmError,
  placeholder: "Confirm email address",
  style: .leftIcon(.user, divider: true)
)
```
