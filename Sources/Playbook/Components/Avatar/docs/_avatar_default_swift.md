![avatar-default](https://github.com/powerhome/playbook-swift/assets/54749071/6005a0b6-8ab2-4c24-ac99-e9e590602849)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBAvatar(image: Image("andrew", bundle: .module), size: .xxSmall, status: .online)
  PBAvatar(image: Image("andrew", bundle: .module), size: .xSmall, status: .away)
  PBAvatar(image: Image("andrew", bundle: .module), size: .small, status: .online)
  PBAvatar(image: Image("andrew", bundle: .module), size: .medium, status: .away)
  PBAvatar(image: Image("andrew", bundle: .module), size: .large, status: .online)
  PBAvatar(image: Image("andrew", bundle: .module), size: .xLarge, status: .offline)
 }
```
