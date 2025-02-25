```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBTextArea(
    "Count Only",
    text: $countText,
    characterCount: .count
  )
  PBTextArea(
    "Max Characters",
    text: $maxCharacterText,
    characterCount: .maxCharacterCount(100)
  )
  PBTextArea(
    "Max Characters W/ Blocker",
    text: $maxBlockerText,
    characterCount: .maxCharacterCountBlock(100)
  )
  PBTextArea(
    "Max Characters W/ Error",
    text: $maxBlockerErrorText,
    characterCount: .maxCharacterCountError(90, "Too many characters!")
)
```
