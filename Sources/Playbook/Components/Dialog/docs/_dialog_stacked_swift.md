[!Dialog-stacked](https://github.com/powerhome/playbook-swift/assets/112719604/4d4af495-4a96-426a-9877-6d2d95e234ef)

```swift
@State private var presentDialog1: Bool = false

@State private var presentDialog2: Bool = false
@State private var presentDialog3: Bool = false

VStack(alignment: .leading, spacing: Spacing.small) {
  PBButton(title: "Default Status") {
    disableAnimation()
    presentDialog1.toggle()
}
.fullScreenCover(isPresented: $presentDialog1) {
  PBDialog(
    title: "Are you sure?",
    message: infoMessage,
    variant: .status(.default),
    isStacked: true,
    cancelButton: ("Cancel", closeToast),
    confirmButton: ("Okay", closeToast),
    size: .small
  )
  .backgroundViewModifier(alpha: 0.2)
}
```
