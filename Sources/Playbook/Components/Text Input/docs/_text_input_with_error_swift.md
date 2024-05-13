![Text-Input-Error](https://github.com/powerhome/playbook-swift/assets/112719604/4fc91c69-81b3-492e-9416-2a5e8fa8defb)


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
