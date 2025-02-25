![Text-Input-Addon](https://github.com/powerhome/playbook-swift/assets/112719604/7fdfaaea-b46f-4041-9c0c-2d4aefdedc89)

```swift
 PBTextInput(
  "ADD ON WITH DEFAULTS",
  text: $textAddOn,
  style: .rightIcon(.user, divider: true)
)
PBTextInput(
  "RIGHT-ALIGNED ADD ON WITH BORDER",
  text: $textAddOnRight,
  style: .rightIcon(.user, divider: true)
)
PBTextInput(
  "RIGHT-ALIGNED ADD ON WITH NO BORDER",
  text: $textAddOnRightNoBorder,
  style: .rightIcon(.user, divider: false)
)
PBTextInput(
  "LEFT-ALIGNED ADD ON WITH NO BORDER",
  text: $textAddOnLeft,
  style: .leftIcon(.user, divider: false)
)
PBTextInput(
  "LEFT-ALIGNED ADD ON WITH BORDER",
  text: $textAddOnLeftNoBorder,
  style: .leftIcon(.user, divider: true)
)
```
