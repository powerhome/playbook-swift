```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  VStack(alignment: .leading, spacing: Spacing.xxSmall) {
    Text("Load forever").pbFont(.caption)
    PBMessage(
      avatar: AnyView(Mocks.picPatric),
      label: "Patrick Welch",
      message: "We will escalate this issue to a Senior Support agent.",
      timestamp: nil,
      timestampAlignment: .leading,
      isLoading: .constant(true)
    )
  }
  VStack(alignment: .leading, spacing: Spacing.xxSmall) {
    Text("Load for 5 seconds").pbFont(.caption)
    PBMessage(
      avatar: AnyView(Mocks.picPatric),
      label: "Patrick Welch",
      message: "We will escalate this issue to a Senior Support agent.",
      timestamp: Date().addingTimeInterval(-540),
      timestampAlignment: .leading,
      isLoading: $isLoading
    )
     .onAppear {
       isLoading = true
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
          self.isLoading = false
        }
    }
  }
}
```
