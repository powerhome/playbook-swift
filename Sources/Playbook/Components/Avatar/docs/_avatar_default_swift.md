
<img width="1326" alt="Avatar (Default)" src="https://github.com/powerhome/playbook-swift/assets/54749071/9ab09b2d-fb9a-4b61-8c2e-3845e6f4ecc4">

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
