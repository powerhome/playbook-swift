![Textarea-Default](https://github.com/powerhome/playbook-swift/assets/112719604/0e2d0f6e-6b9e-4abe-bef0-b1f8e2ce725f)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBTextArea(
    "Label",
    text: $defaultText
  )
  PBTextArea(
    "Label",
    text: $placeholderText,
    placeholder: "Placeholder with text"
  )
  PBTextArea(
    "Label",
    text: $customText
  )
}
```
