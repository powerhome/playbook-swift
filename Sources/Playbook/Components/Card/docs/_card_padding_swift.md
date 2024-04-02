![card-padding](https://github.com/powerhome/playbook-swift/assets/54749071/4f6fa99b-0136-48de-acf6-1e41cf16a393)

```swift
VStack(spacing: Spacing.small) {
  PBCard(padding: Spacing.none) {
    Text("None").pbFont(.body)
  }

  PBCard(padding: Spacing.xxSmall) {
    Text("XX Small").pbFont(.body)
  }

  PBCard(padding: Spacing.xSmall) {
    Text("X Small").pbFont(.body)
  }

  PBCard(padding: Spacing.small) {
    Text("Small").pbFont(.body)
  }

  PBCard(padding: Spacing.medium) {
    Text("Medium").pbFont(.body)
  }

  PBCard(padding: Spacing.large) {
    Text("Large").pbFont(.body)
  }

  PBCard(padding: Spacing.xLarge) {
    Text("X Large").pbFont(.body)
  }
 }
```
