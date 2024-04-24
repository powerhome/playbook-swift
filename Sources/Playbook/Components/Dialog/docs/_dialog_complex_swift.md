```swift
@State private var presentDialog: Bool = false
@State private var message = ""
     
  func closeToast() {
    presentDialog = false
  }

PBButton(title: "Complex") {
  disableAnimation()
  presentDialog.toggle()
}
.fullScreenCover(isPresented: $presentDialog) {
  VStack{
    PBDialog(
      title: "Send us your thoughts!",
      cancelButton: ("Cancel", closeToast),
      confirmButton: ("Submit", closeToast),
      content: ({
    ScrollView {
      complexTitle
      complexLabel
    }
  }))
   .backgroundViewModifier(alpha: 0.2)
  }
}
```
