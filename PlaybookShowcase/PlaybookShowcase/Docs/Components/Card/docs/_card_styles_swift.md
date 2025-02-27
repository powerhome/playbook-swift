![card-styles](https://github.com/powerhome/playbook-swift/assets/54749071/c70a8b60-2865-437f-ac3a-794bca1d9d6c)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBCard {
    Text("Card Context").pbFont(.body)
  }

  PBCard(style: .selected()) {
    Text("Card Context").pbFont(.body)
  }
  
  PBCard(style: .error) {
    Text("Card Context").pbFont(.body)
  }
 }
```
