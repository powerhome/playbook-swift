![User-Vertical](https://github.com/powerhome/playbook-swift/assets/112719604/05eeb83a-fa14-4594-a094-4de6f7e674ca)

```swift
VStack(alignment: .leading, spacing: Spacing.small) {
  PBUser(
    name: name,
    image: img,
    orientation: .vertical,
    size: .small,
    title: title
  )
  PBUser(
    name: name,
    image: img,
    orientation: .vertical,
    title: title
  )
  PBUser(
    name: name,
    image: img,
    orientation: .vertical,
    size: .large,
    title: title
  )
}
```
