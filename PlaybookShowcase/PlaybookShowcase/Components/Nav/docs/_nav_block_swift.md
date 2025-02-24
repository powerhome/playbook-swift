```swift
PBNav(
  selected: $selectedCustom,
  variant: .normal,
  orientation: .vertical,
  title: "Users"
) {
  PBNavItem {
    PBUser(
      name: "Anna Black",
      image: Image("Anna"),
      size: .small,
      title: "PHL • Remodeling Consultant"
    )
  }
  PBNavItem {
    PBUser(
      name: "Julie",
      image: Image("Julie"),
      size: .small,
      title: "PHL • Sales Agent"
    )
  }
  PBNavItem {
    PBUser(
      name: "Denis Wilks",
      image: Image("andrew"),
      size: .small,
      title: "PHL • Remodeling Consultant"
    )
  }
}
```
