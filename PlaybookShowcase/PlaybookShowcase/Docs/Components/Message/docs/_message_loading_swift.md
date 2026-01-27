```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  VStack(alignment: .leading, spacing: Spacing.xxSmall) {
    Text("Load forever").pbFont(.caption)
    PBMessage(
      avatar: AnyView(Mocks.picPatric),
      sender: "Patrick Welch",
      timestamp: nil,
      message: AttributedString("We will escalate this issue to a Senior Support agent."),
      isLoading: true
    )
  }
  VStack(alignment: .leading, spacing: Spacing.xxSmall) {
    Text("Load for 5 seconds").pbFont(.caption)
    PBMessage(
      avatar: AnyView(Mocks.picPatric),
      sender: "Patrick Welch",
      timestamp: Date().addingTimeInterval(-540),
      message: AttributedString("We will escalate this issue to a Senior Support agent."),
      isLoading: isLoading
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
