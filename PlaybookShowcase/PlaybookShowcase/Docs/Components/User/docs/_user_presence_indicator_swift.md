![User-Presence-Indicator](https://github.com/powerhome/playbook-swift/assets/112719604/71e16713-433e-4e75-ac30-ee440955c7d9)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBUser(
    name: name,
    image: img,
    size: .small,
    territory: "PHL",
    title: title,
    status: .online
  )
  PBUser(
    name: name,
    image: img,
    territory: "PHL",
    title: title,
    status: .away
  )
  PBUser(
    name: name,
    image: img,
    size: .large,
    territory: "PHL",
    title: title,
    status: .offline
  )
}
```
