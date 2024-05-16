![Tab-Bar-Default](https://github.com/powerhome/playbook-swift/assets/112719604/9960e245-a398-4ba3-bb0b-040561536395)

```swift
@State var selectedTab: Int? = 0

PBTabBar(
  selectedTab: $selectedTab,
  border: false,
  shadow: true,
  icons: TabBarCatalog.icons
)
```
