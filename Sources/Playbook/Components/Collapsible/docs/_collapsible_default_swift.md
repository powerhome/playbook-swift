![collapsible-default](https://github.com/powerhome/playbook-swift/assets/54749071/fc45141f-b898-4b19-adb2-15f16a9322aa)

```swift
let iconSize: PBIcon.IconSize
let iconColor: CollapsibleIconColor
let text: String
@State private var isCollapsed = true
let lorem =
      "
      Group members... Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vel erat sed purus hendrerit vive.
      Etiam nunc massa, pharetra vel quam id, posuere rhoncus quam. Quisque imperdiet arcu enim, nec aliquet justo.
      Praesent lorem arcu. Vivamus suscipit, libero eu fringilla egestas, orci urna commodo arcu, vel gravida turpis.
      "

PBCollapsible(isCollapsed: $isCollapsed, iconSize: iconSize, iconColor: iconColor) {
        CollapsibleDoc(text: "Main Section")
      } content: {
        Text(lorem).pbFont(.body)
      }

```
