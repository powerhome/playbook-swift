![card-shadow](https://github.com/powerhome/playbook-swift/assets/54749071/51b3fe01-07fb-46a0-8391-09879c56bf22)

```swift
VStack(spacing: Spacing.small) {
  PBCard(shadow: Shadow.deep) {
    Text("Deep").pbFont(.body)
  }

  PBCard(shadow: Shadow.deeper) {
    Text("Deeper").pbFont(.body)
  }

  PBCard(shadow: Shadow.deepest) {
    Text("Deepest").pbFont(.body)
  }

  PBCard(shadow: Shadow.none) {
    Text("None").pbFont(.body)
  }
 }
```
