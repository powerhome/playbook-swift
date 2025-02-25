![dialog-large](https://github.com/powerhome/playbook-swift/assets/54749071/777ad37b-52b8-4b81-ac39-28bba15cad6d)

```swift
let title: String
let size: DialogSize
@State private var presentDialog: Bool = false
PBButton(title: title) {
  disableAnimation()
  presentDialog.toggle()
}
.fullScreenCover(isPresented: $presentDialog) {
  PBDialog(
    title: "\(title) Dialog",
    message: infoMessage,
    cancelButton: ("Cancel", closeToast),
    confirmButton: ("Okay", closeToast),
    size: size
  )
  .backgroundViewModifier(alpha: 0.2)
```
