![Tab-Bar-3-Options](https://github.com/powerhome/playbook-swift/assets/112719604/032d0de5-a1c3-4c23-a622-d299d441d7d7)

```swift
static let icons: [TabIcon] = [
  .init(icon: .home, name: "Home"),
  .init(icon: .calendar, name: "Calendar"),
  .init(icon: .bell, name: "Notfications"),
  .init(icon: .search, name: "Search"),
  .init(icon: .ellipsisH, name: "More"),
]
PBTabBar(
  selectedTab: $selectedTab4,
  border: false,
  shadow: true,
  icons: TabBarCatalog.icons.prefix(4).dropLast()
)
```
