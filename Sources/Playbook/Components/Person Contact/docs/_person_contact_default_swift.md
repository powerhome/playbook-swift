![Person-Contact_Default](https://github.com/powerhome/playbook-swift/assets/54749071/7da40c0d-ba83-43ad-8cf9-8b2da293fc4e)

```swift
let contacts = [
  PBContact(type: .email, value: "email@example.com", detail: false),
  PBContact(type: .home, value: "(555) 555-5555", detail: false),
  PBContact(type: .work, value: "(324) 562-7482", detail: false)
]
  return PBPersonContact(firstName: "Pauline", lastName: "Smith", contacts: contacts)
```
