![button-icon-positions](https://github.com/powerhome/playbook-swift/assets/54749071/6a5054e1-3a10-4d70-802d-c4792ad8c3d5)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBButton(
    title: "Button with Icon on Left",
    icon: PBIcon.fontAwesome(.user, size: .x1),
    action: {}
  )
  PBButton(
    title: "Button with Icon on Right",
    icon: PBIcon.fontAwesome(.user, size: .x1),
    iconPosition: .right,
    action: {}
  )
 }
```
