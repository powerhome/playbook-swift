![Tab-Bar-4-Options](https://github.com/powerhome/playbook-swift/assets/112719604/3aa9d23d-8d89-48c7-a460-9d4bc1548b16)

```swift
@State var selectedTab3: Int? = 0


PBTabBar(
  selectedTab: $selectedTab3,
  border: false,
  shadow: true,
  icons: icons: [
    TabIcon(icon: .home, name: "Home"),
    TabIcon(icon: .calendar, name: "Calendar"),
    TabIcon(icon: .bell, name: "Notfications"),
    TabIcon(icon: .search, name: "Search")
  ]
)
```
