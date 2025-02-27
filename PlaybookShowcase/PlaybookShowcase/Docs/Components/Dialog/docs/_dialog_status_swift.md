![success](https://github.com/powerhome/playbook-swift/assets/54749071/5640ecd4-5f2d-4cf5-8742-ebffd33581c3)

```swift
@State private var presentDialog: DialogStatus?

VStack(alignment: .leading, spacing: Spacing.small) {
  ForEach(DialogStatus.allCases, id: \.self) { status in
    PBButton(title: status.rawValue.capitalized) {
    disableAnimation()
    presentDialog = status
}
.fullScreenCover(item: $presentDialog) { item in
  PBDialog(
    title: item.rawValue.capitalized,
    message: infoMessage,
    variant: .status(item),
    isStacked: false,
    cancelButton: ("Cancel", closeToast),
    confirmButton: ("Okay", closeToast)
  )
  .backgroundViewModifier(alpha: 0.2)
    }
  }
}
```
