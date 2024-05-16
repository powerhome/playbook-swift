![Tab-Bar-With-Border](https://github.com/powerhome/playbook-swift/assets/112719604/9d059a59-e710-4f20-b713-a54d56b671c3)

```swift
@State var selectedTab2: Int? = 0

PBTabBar(
  selectedTab: $selectedTab2,
  border: true,
  shadow: false,
  icons: TabBarCatalog.icons
)
```
