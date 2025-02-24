```swift
PBNav(
  selected: $selectedVCustomIcon,
  variant: .normal,
  orientation: .vertical,
  title: "Browse"
) {
  PBNavItem(
    "News Feed",
    icon: .custom(AnyView(Image(systemName: "newspaper")))
  )
  PBNavItem(
    "Messages",
    icon: .custom(AnyView(Image(systemName: "bubble.left.and.bubble.right")))
  )
  PBNavItem(
    "Events",
    icon: .custom(AnyView(Image(systemName: "calendar")))
  )
  PBNavItem(
    "Friends",
    icon: .custom(AnyView(Text("👯‍♂️")))
  )
  PBNavItem(
    "Groups",
    icon: .custom(AnyView(Text("👨‍👩‍👦‍👦")))
  )
}
```
