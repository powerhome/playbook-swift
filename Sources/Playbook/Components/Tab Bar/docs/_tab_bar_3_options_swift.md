![Tab-Bar-3-Options](https://github.com/powerhome/playbook-swift/assets/112719604/032d0de5-a1c3-4c23-a622-d299d441d7d7)

```swift
@State var selectedTab4: Int? = 0

PBTabBar(
  selectedTab: $selectedTab4,
  border: false,
  shadow: true,
  icons: [
    TabIcon(icon: .home, name: "Home"),
    TabIcon(icon: .calendar, name: "Calendar"),
    TabIcon(icon: .bell, name: "Notfications")
  ]
)
```
