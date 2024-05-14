![Tab-Bar-4-Options](https://github.com/powerhome/playbook-swift/assets/112719604/3aa9d23d-8d89-48c7-a460-9d4bc1548b16)

```swift
 static let icons: [TabIcon] = [
  .init(icon: .home, name: "Home"),
  .init(icon: .calendar, name: "Calendar"),
  .init(icon: .bell, name: "Notfications"),
  .init(icon: .search, name: "Search"),
  .init(icon: .ellipsisH, name: "More"),
]
PBTabBar(
  selectedTab: $selectedTab3,
  border: false,
  shadow: true,
  icons: TabBarCatalog.icons.prefix(5).dropLast()
)
```
