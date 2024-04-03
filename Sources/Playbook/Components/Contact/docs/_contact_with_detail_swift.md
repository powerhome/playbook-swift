![contact-detail-indicator](https://github.com/powerhome/playbook-swift/assets/54749071/ff0abc6a-66f1-478f-bb4c-d26e3ae5fa29)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBContact(type: .cell, value: "3491859988", detail: true)
  PBContact(value: "5555555555", detail: true)
  PBContact(type: .email, value: "email@example.com", detail: true)
  PBContact(type: .work, value: "3245627482", detail: true)
  PBContact(type: .ext, value: "1234", detail: true)
}
```
