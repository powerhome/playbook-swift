```swift
let contacts = [
  PBContact(type: .email, value: "email@example.com", detail: false),
  PBContact(type: .home, value: "(555) 555-5555", detail: false),
  PBContact(type: .work, value: "(324) 562-7482", detail: false)
]
  return PBPersonContact(firstName: "Pauline", lastName: "Smith", contacts: contacts)
```
