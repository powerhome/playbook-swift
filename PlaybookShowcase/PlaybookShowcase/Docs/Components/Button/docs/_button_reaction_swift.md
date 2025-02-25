![reaction-button](https://github.com/powerhome/playbook-swift/assets/54749071/fa963098-3bbd-4f3b-92bf-e314e50839bf)


```swift
@State private var count: Int = 153
@State private var count1: Int = 5

HStack(alignment: .center, spacing: 12) {
            PBReactionButton(
              count: $count,
              icon: "\u{1F389}",
              isInteractive: true
            )
            PBReactionButton(
              count: $count1,
              icon: "1️⃣",
              isInteractive: false
            )
            PBReactionButton(
              isInteractive: false
            )
            PBReactionButton(
              pbIcon: PBIcon(FontAwesome.user),
              isInteractive: false
            )
}
```
