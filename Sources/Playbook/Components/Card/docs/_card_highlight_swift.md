![card-highlight](https://github.com/powerhome/playbook-swift/assets/54749071/df6e0c21-21fe-4cf3-a992-c44c48a4eb69)


```swift
VStack(spacing: Spacing.small) {
  PBCard(highlight: .side(.product(.product6, category: .highlight))) {
    Text("Side Position & Product 6 Highlight Color").pbFont(.body)
  }

  PBCard(highlight: .top(.status(.warning))) {
    Text("Top Position & Warning Color").pbFont(.body)
  }

  PBCard(highlight: .side(.category(.category2))) {
    Text("Side Position & Category 2 Color").pbFont(.body)
  }
 }
```
