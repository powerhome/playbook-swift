![Tab-Bar-Without-Shadow](https://github.com/powerhome/playbook-swift/assets/112719604/94616769-4560-4cf0-bf8e-9e929ef3445e)

```swift
@State var selectedTab1: Int? = 0

PBTabBar(
  selectedTab: $selectedTab1,
  border: false,
  shadow: false,
  icons:  icons:  icons: [
    TabIcon(icon: .home, name: "Home"),
    TabIcon(icon: .calendar, name: "Calendar"),
    TabIcon(icon: .bell, name: "Notfications"),
    TabIcon(icon: .search, name: "Search"),
    TabIcon(icon: .ellipsisH, name: "More")
  ]
)
```
