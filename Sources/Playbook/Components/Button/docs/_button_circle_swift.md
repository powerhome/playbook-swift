![button-circles](https://github.com/powerhome/playbook-swift/assets/54749071/390b3498-3069-414f-935f-594b7a15fce2)


```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBButton(
    shape: .circle,
    icon: PBIcon.fontAwesome(.plus, size: .x1),
    action: {}
  )
  PBButton(
    variant: .secondary,
    shape: .circle,
    icon: PBIcon.fontAwesome(.pen, size: .x1),
    action: {}
  )
  PBButton(
    variant: .disabled,
    shape: .circle,
    icon: PBIcon.fontAwesome(.times, size: .x1)
  )
  PBButton(
    variant: .link,
    shape: .circle,
    icon: PBIcon.fontAwesome(.user, size: .x1),
    action: {}
  )
 }
```
