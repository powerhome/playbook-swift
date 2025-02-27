```swift
PBNav(
  selected: $selectedVSubtleWithIcon,
  variant: .subtle,
  orientation: .vertical
) {
  PBNavItem("News Feed", icon: .pbIcon(.fontAwesome(.newspaper)))
  PBNavItem("Messages", icon: .pbIcon(.fontAwesome(.messages)))
  PBNavItem("Events", icon: .pbIcon(.fontAwesome(.calendarCheck)))
  PBNavItem("Friends", icon: .pbIcon(.fontAwesome(.peopleCarry)))
  PBNavItem("Groups", icon: .pbIcon(.fontAwesome(.campground)))
}
```
