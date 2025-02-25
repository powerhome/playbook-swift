![button-default](https://github.com/powerhome/playbook-swift/assets/54749071/9a5982b8-09a1-44ed-9a56-3fda85406483)


```swift
VStack(alignment: .leading, spacing: Spacing.small) {
   PBButton(
     title: "Button Primary",
     action: {}
    )
    PBButton(
      variant: .secondary,
      title: "Button Secondary",
      action: {})
    PBButton(
      variant: .link,
      title: "Button Link",
      action: {}
    )
    PBButton(
      variant: .disabled,
      title: "Button Disabled"
    )
 }
```
