![card-border-radius](https://github.com/powerhome/playbook-swift/assets/54749071/aa9e2486-d5e9-4e71-b4f4-f037edb4a45f)

```swift
VStack(spacing: Spacing.small) {
  PBCard(borderRadius: BorderRadius.none) {
    Text("None").pbFont(.body)
  }

  PBCard(borderRadius: BorderRadius.xSmall) {
    Text("X Small").pbFont(.body)
  }

  PBCard(borderRadius: BorderRadius.small) {
    Text("Small").pbFont(.body)
  }

  PBCard(borderRadius: BorderRadius.medium) {
    Text("Medium").pbFont(.body)
  }

  PBCard(borderRadius: BorderRadius.large) {
    Text("Large").pbFont(.body)
  }

   PBCard(borderRadius: BorderRadius.xLarge) {
    Text("X Large").pbFont(.body)
  }

   PBCard(borderRadius: BorderRadius.rounded) {
    Text("Rounded").pbFont(.body)
  }
 }
 ``````
