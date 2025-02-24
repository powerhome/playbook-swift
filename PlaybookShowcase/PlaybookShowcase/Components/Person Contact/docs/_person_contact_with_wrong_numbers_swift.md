![Person-Contact-Wrong-Number](https://github.com/powerhome/playbook-swift/assets/54749071/39ce25ce-8479-4b8b-93b5-00b3d78146bf)

```swift
VStack(alignment: .leading, spacing: Spacing.xSmall) {
  PBPersonContact(firstName: "Pauline", lastName: "Smith", contacts: [PBContact(type: .email, value: "email@example.com", detail: false), PBContact(type: .home, value: " (555) 555-5555", detail: false), PBContact(type: .home, value: "(304) 861-5385", detail: false)])
  PBPersonContact(firstName: "", lastName: "", contacts: [PBContact(type: .custom("", .phoneSlash), value: "(324) 562-7482", detail: false)])
}
```
