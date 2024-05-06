```swift
VStack(alignment: .leading, spacing: Spacing.xSmall) {
  PBPersonContact(firstName: "Harvey", lastName: "Walters", contacts: [PBContact(type: .email, value: "email@example.com", detail: false), PBContact(type: .home, value: "(555) 555-5555", detail: false), PBContact(type: .work, value: "(324) 562-7482", detail: false)])
  Spacer()
  PBPersonContact(firstName: "Brenda", lastName: "Walters", contacts: [PBContact(type: .home, value: "(555) 555-5555", detail: false)])
}
```
