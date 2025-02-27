![user-default](https://github.com/powerhome/playbook-swift/assets/54749071/be691876-02d2-4c52-9e8b-54c96d35bfdc)

```swift
@State private var presentDialog: Bool = false

PBButton(title: "Simple") {
  disableAnimation()
  presentDialog.toggle()
}
.fullScreenCover(isPresented: $presentDialog) {
  PBDialog(
    title: "This is some informative text",
    message: infoMessage,
    cancelButton: ("Cancel", closeToast),
    confirmButton: ("Okay", closeToast)
  )
  .backgroundViewModifier(alpha: 0.2)
}
```
