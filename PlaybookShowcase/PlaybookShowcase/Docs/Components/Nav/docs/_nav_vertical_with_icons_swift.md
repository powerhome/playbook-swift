```swift
PBNav(
  selected: $selectedVIcon,
  variant: .normal,
  orientation: .vertical,
  title: "Browse"
) {
  PBNavItem("News Feed", icon: .pbIcon(.fontAwesome(.newspaper)), accessory: .chevronDown)
  PBNavItem("Messages", icon: .pbIcon(.fontAwesome(.messages)))
  PBNavItem("Events", icon: .pbIcon(.fontAwesome(.calendarCheck)))
  PBNavItem("Friends", icon: .pbIcon(.fontAwesome(.peopleCarry)))
  PBNavItem("Groups", icon: .pbIcon(.fontAwesome(.campground)))
}
```
