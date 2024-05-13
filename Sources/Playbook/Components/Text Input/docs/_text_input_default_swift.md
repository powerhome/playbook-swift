![Text-Input-Default](https://github.com/powerhome/playbook-swift/assets/112719604/2c43b941-69cc-426f-a39d-c619d621a898)

```swift
PBTextInput(
  "First name",
  text: $textFirstName,
  placeholder: "Enter first name"
)
PBTextInput(
  "Last name",
  text: $textLastName,
  placeholder: "Enter last name"
)
PBTextInput(
  "Phone number",
  text: $textPhone,
  placeholder: "Enter phone number",
  keyboardType: .phonePad
)
PBTextInput(
  "Email",
  text: $textEmail,
  placeholder: "Enter email address",
  keyboardType: .emailAddress
)
PBTextInput(
  "Zip code",
  text: $textZip,
  placeholder: "Enter zip code",
  keyboardType: .numberPad
)
```
